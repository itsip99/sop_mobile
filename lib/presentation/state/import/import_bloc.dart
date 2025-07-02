import 'package:flutter_bloc/flutter_bloc.dart';
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
      emit(ImportInitial());
      emit(ImportExcelSucceed('success'));
    } catch (e) {
      emit(ImportExcelFailed(e.toString()));
    }
  }
}
