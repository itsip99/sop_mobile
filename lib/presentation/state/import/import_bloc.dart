import 'dart:io';

import 'package:excel/excel.dart' as xls;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/sales_import.dart';
import 'package:sop_mobile/presentation/state/import/import_event.dart';
import 'package:sop_mobile/presentation/state/import/import_state.dart';

class ImportBloc extends Bloc<ImportEvent, ImportState> {
  ImportBloc() : super(ImportInitial()) {
    on<ImportResetEvent>(importReset);
    on<ImportExcelEvent>(importExcel);
  }

  Future<void> importReset(
    ImportResetEvent event,
    Emitter<ImportState> emit,
  ) async {
    try {
      emit(ImportInitial());
    } catch (e) {
      emit(ImportExcelFailed(e.toString()));
    }
  }

  Future<void> importExcel(
    ImportExcelEvent event,
    Emitter<ImportState> emit,
  ) async {
    try {
      emit(ImportLoading());

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx', 'xls'],
      );

      if (result != null && result.files.single.path != null) {
        // 3. Parse File and Update Bloc
        File file = File(result.files.single.path!);

        // 3. Parse File and Update Bloc
        var bytes = file.readAsBytesSync();
        var excel = xls.Excel.decodeBytes(bytes);

        // Assumption: Data is in the first sheet named 'Sheet1'
        // Assumption: Columns are Name, Status, SPK, STU, STU LM
        var sheet = excel['Sheet1'];

        List<SalesImportModel> importedSalesmen = [];
        // Skip the first row (header)
        for (var row in sheet.rows.skip(1)) {
          // Check for null cells to avoid errors
          final String id = row[0]?.value?.toString() ?? '';
          final String name = row[1]?.value?.toString() ?? '';
          final String tier = row[2]?.value?.toString() ?? '';

          if (id.isNotEmpty && name.isNotEmpty && tier.isNotEmpty) {
            importedSalesmen.add(
              SalesImportModel(id: id, name: name, tier: tier),
            );
          }
        }

        if (importedSalesmen.isNotEmpty) {
          emit(ImportExcelSucceed('success', importedSalesmen));
        } else {
          emit(ImportExcelFailed('failed'));
        }
      } else {
        emit(ImportExcelFailed('failed'));
      }
    } catch (e) {
      emit(ImportExcelFailed(e.toString()));
    }
  }
}
