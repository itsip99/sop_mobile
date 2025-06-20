import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/domain/repositories/sales.dart';
import 'package:sop_mobile/domain/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_event.dart';
import 'package:sop_mobile/presentation/state/salesman/salesman_state.dart';
import 'package:sop_mobile/presentation/widgets/datagrid/insertation/report_salesman.dart';

class SalesmanBloc<BaseEvent, BaseState>
    extends Bloc<SalesmanEvent, SalesmanState> {
  final SalesRepo salesRepo;
  final StorageRepo storageRepo;

  SalesmanBloc({required this.salesRepo, required this.storageRepo})
      : super(SalesmanInitial([], [], [])) {
    on<ResetSalesman>(
      (event, emit) => emit(SalesmanInitial([], [], event.salesDraftList)),
    );
    on<FetchSalesman>(fetchSalesmanHandler);
    on<AddSalesman>(addSalesmanHandler);
    on<ModifySalesman>(modifySalesmanHandler);
    // on<RemoveSalesman>(removeSalesmanHandler);
  }

  /// Dynamically creates a list of SalesmanData using state.fetchSalesList,
  /// extracting only the name and tier, and setting other parameters to 0.
  List<SalesmanData> buildSalesmanDataListFromFetchSalesList() {
    return state.fetchSalesList.map((sales) {
      return SalesmanData(
        sales.userName,
        sales.tierLevel,
        0,
        0,
        0,
      );
    }).toList();
  }

  Future<void> fetchSalesmanHandler(
    FetchSalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    emit(SalesmanLoading(state));
    try {
      // ~:Secure Storage Simulation:~
      UserCredsModel userCredentials =
          await storageRepo.getUserCredentials();

      if (userCredentials.username != '') {
        // ~:Network Call Simulation:~
        Map<String, dynamic> result =
            await salesRepo.fetchSalesman(userCredentials.username);

        if (result['status'] == 'success') {
          List<SalesmanData> salesDataList =
              (result['data'] as List<SalesModel>)
                  .map((e) => SalesmanData(
                        e.userName,
                        e.tierLevel,
                        0,
                        0,
                        0,
                      ))
                  .toList();

          log('Salesman data fetched successfully: ${salesDataList.length} entries');

          // ~:Emit success state with user data:~
          emit(SalesmanFetched(
            state,
            result['data'] as List<SalesModel>,
            salesDataList,
          ));
        } else {
          // ~:Emit failure state with an error message:~
          emit(SalesmanError(result['data']));
        }
      } else {
        emit(SalesmanError('User credentials not found'));
      }
    } catch (e) {
      emit(SalesmanError(e.toString()));
    }
  }

  Future<void> addSalesmanHandler(
    AddSalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    emit(SalesmanLoading(state));
    try {
      // ~:Secure Storage Simulation:~
      UserCredsModel userCredentials =
          await storageRepo.getUserCredentials();

      if (userCredentials.username != '') {
        // ~:Network Call Simulation:~
        Map<String, dynamic> result = await salesRepo.addSalesman(
          userCredentials.username,
          event.id,
          event.name,
          event.tier,
        );

        if (result['status'] == 'success') {
          // ~:Emit success state with user data:~
          emit(SalesmanAdded());
        } else {
          // ~:Emit failure state with an error message:~
          emit(SalesmanError(result['data'] as String));
        }
      } else {
        emit(SalesmanError('User credentials not found'));
      }
      // emit(SalesmanAdded(
      //   state,
      //   SalesProfileModel(event.id, event.name, event.tier),
      // ));
    } catch (e) {
      emit(SalesmanError(e.toString()));
    }
  }

  Future<void> modifySalesmanHandler(
    ModifySalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    try {
      log('Modify Salesman Handler called');
      List<SalesmanData> newList = [];
      if (state is SalesmanFetched) {
        // Create a NEW list based on the current state's data
        newList =
            List<SalesmanData>.from((state as SalesmanFetched).salesDataList);
      } else if (state is SalesmanModified) {
        newList =
            List<SalesmanData>.from((state as SalesmanModified).salesDataList);
      } else {
        log('State is not SalesmanFetched, cannot modify sales data');
        emit(SalesmanError('No sales data available to modify'));
      }

      for (var entry in newList) {
        log('Salesman: ${entry.name}, SPK: ${entry.spk}, STU: ${entry.stu}, STU LM: ${entry.stuLm}');
      }

      SalesmanData entryToUpdate = newList[event.rowIndex];

      log('Entry to update: ${entryToUpdate.name}, SPK: ${entryToUpdate.spk}, STU: ${entryToUpdate.stu}, STU LM: ${entryToUpdate.stuLm}');
      int currentSpk = entryToUpdate.spk;
      int currentStu = entryToUpdate.stu;
      int currentStuLm = entryToUpdate.stuLm;
      log('Current SPK: $currentSpk, Current STU: $currentStu, Current STU LM: $currentStuLm');

      if (event.newSpkValue != null) {
        currentSpk = event.newSpkValue!;
      }
      if (event.newStuValue != null) {
        currentStu = event.newStuValue!;
      }
      if (event.newLmValue != null) {
        currentStuLm = event.newLmValue!;
      }
      log('Updated SPK: $currentSpk, Updated STU: $currentStu, Updated STU LM: $currentStuLm');

      // Create new LeasingData with updated values
      newList[event.rowIndex] = entryToUpdate.copyWith(
        spk: currentSpk,
        stu: currentStu,
        stuLm: currentStuLm,
      );

      log('Row ${event.rowIndex} updated: SPK: $currentSpk, STU: $currentStu, STU LM: $currentStuLm');
      emit(SalesmanModified(newList));
      log('Updated data length: ${newList.length}');
    } catch (e) {
      log('Error modifying salesman data: $e');
      emit(SalesmanError(e.toString()));
    }
  }
}
