import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
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
    on<AddSalesmanList>(addSalesmanListHandler);
    on<ModifySalesman>(modifySalesmanHandler);
    on<ModifySalesmanStatus>(modifySalesmanStatusHandler);
    // on<RemoveSalesman>(removeSalesmanHandler);
  }

  /// Dynamically creates a list of SalesmanData using state.fetchSalesList,
  /// extracting only the name and tier, and setting other parameters to 0.
  List<SalesmanData> buildSalesmanDataListFromFetchSalesList() {
    return state.fetchSalesList.map((sales) {
      return SalesmanData(sales.userName, sales.tierLevel, 0, 0, 0);
    }).toList();
  }

  Future<void> fetchSalesmanHandler(
    FetchSalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    emit(SalesmanLoading(state));
    try {
      // ~:Secure Storage Simulation:~
      UserCredsModel userCredentials = await storageRepo.getUserCredentials();

      if (userCredentials.username != '') {
        // // ~:Network Call Simulation:~
        // Map<String, dynamic> result = await salesRepo.fetchSalesman(
        //   userCredentials.username,
        // );

        // if (result['status'] == 'success') {
        //   List<SalesmanData> salesDataList =
        //       (result['data'] as List<SalesModel>)
        //           .map((e) => SalesmanData(e.userName, e.tierLevel, 0, 0, 0))
        //           .toList();

        //   log(
        //     'Salesman data fetched successfully: ${salesDataList.length} entries',
        //   );

        //   // ~:Emit success state with user data:~
        //   emit(
        //     SalesmanFetched(
        //       state,
        //       result['data'] as List<SalesModel>,
        //       salesDataList,
        //     ),
        //   );
        // } else {
        //   // ~:Emit failure state with an error message:~
        //   emit(SalesmanError(result['data']));
        // }
        final result = await salesRepo.fetchSalesman(userCredentials.username);

        if (result['status'] == 'success') {
          final List<SalesModel> fetchedList =
              result['data'] as List<SalesModel>;

          // Map from the API model to our new UI model
          final List<SalesmanData> uiList =
              fetchedList
                  .map(
                    (apiModel) => SalesmanData(
                      apiModel.userName,
                      apiModel.tierLevel,
                      0,
                      0,
                      0,
                    ),
                  )
                  .where(
                    (e) => fetchedList.any(
                      (f) => f.userName == e.name && f.isActive == 1,
                    ),
                  )
                  .toList();

          emit(SalesmanFetched(state, fetchedList, uiList));
        } else {
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
      UserCredsModel userCredentials = await storageRepo.getUserCredentials();

      if (userCredentials.username != '') {
        // ~:Network Call Simulation:~
        Map<String, dynamic> result = await salesRepo.addOrModifySalesman(
          userCredentials.username,
          event.id,
          event.name,
          event.tier,
          event.status,
        );

        if (result['status'] == 'success') {
          // ~:Emit success state with user data:~
          emit(SalesmanAdded());
        } else {
          if ((result['data'] as String).contains('duplicate key')) {
            emit(SalesmanError('Duplicate ID found'));
          } else {
            emit(SalesmanError(result['data'] as String));
          }
        }
      } else {
        emit(SalesmanError('User credentials not found'));
      }
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(SalesmanError(e.toString()));
    }
  }

  Future<void> addSalesmanListHandler(
    AddSalesmanList event,
    Emitter<SalesmanState> emit,
  ) async {
    emit(SalesmanLoading(state));
    try {
      UserCredsModel userCredentials = await storageRepo.getUserCredentials();

      if (userCredentials.username != '') {
        List<Map<String, dynamic>> results = [];
        bool hasError = false;
        String? errorMessage;

        // Process each salesman in the list
        for (var salesman in event.salesDraftList) {
          try {
            Map<String, dynamic> result = await salesRepo.addOrModifySalesman(
              userCredentials.username,
              Formatter.removeSpaces(salesman.id),
              Formatter.removeSpaces(salesman.name),
              Formatter.removeSpaces(salesman.tier),
              salesman.isActive,
            );

            results.add({
              'success': result['status'] == 'success',
              'message': result['data'] as String,
            });

            // If any insert fails, mark as error but continue processing others
            if (result['status'] != 'success') {
              hasError = true;
              errorMessage = result['data'] as String;
            }
          } catch (e) {
            hasError = true;
            errorMessage = e.toString();
            results.add({'success': false, 'message': e.toString()});
          }
        }

        // After processing all items
        if (hasError) {
          // If any insert failed, show error but include successful ones
          emit(
            SalesmanPartialSuccess(
              results,
              errorMessage: errorMessage ?? 'Some salesmen could not be added',
            ),
          );
        } else {
          // All inserts were successful
          emit(SalesmanAdded(results: results));
        }
      } else {
        emit(SalesmanError('User credentials not found'));
      }
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(SalesmanError('Failed to process salesman list: ${e.toString()}'));
    }
  }

  Future<void> modifySalesmanHandler(
    ModifySalesman event,
    Emitter<SalesmanState> emit,
  ) async {
    try {
      // Only proceed if we have data to modify
      if (state is! SalesmanFetched && state is! SalesmanModified) return;

      // 1. Create a NEW list from the current state's list.
      final List<SalesmanData> newList = List<SalesmanData>.from(
        state.salesDataList,
      );

      // 2. Check for a valid index.
      if (event.rowIndex < 0 || event.rowIndex >= newList.length) return;

      // 3. Get a reference to the specific object to be updated.
      SalesmanData entryToUpdate = newList[event.rowIndex];

      // 4. Use `copyWith` and a switch on the column name to create a new instance.
      switch (event.columnName) {
        case 'SPK':
          entryToUpdate = entryToUpdate.copyWith(spk: event.newValue);
          break;
        case 'STU':
          entryToUpdate = entryToUpdate.copyWith(stu: event.newValue);
          break;
        case 'STU LM':
          entryToUpdate = entryToUpdate.copyWith(stuLm: event.newValue);
          break;
      }

      // 5. Replace the old object with the new one in our new list.
      newList[event.rowIndex] = entryToUpdate;

      // 6. Emit a new state containing the new list.
      emit(SalesmanModified(state, newList));
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(SalesmanError('Failed to modify sales data: ${e.toString()}'));
    }
  }

  Future<void> modifySalesmanStatusHandler(
    ModifySalesmanStatus event,
    Emitter<SalesmanState> emit,
  ) async {
    try {
      // ~:Secure Storage Simulation:~
      UserCredsModel userCredentials = await storageRepo.getUserCredentials();

      if (userCredentials.username != '') {
        // ~:Network Call Simulation:~
        Map<String, dynamic> result = await salesRepo.addOrModifySalesman(
          userCredentials.username,
          Formatter.removeSpaces(event.sales.id),
          Formatter.removeSpaces(event.sales.name),
          Formatter.removeSpaces(event.sales.tier),
          event.sales.isActive,
          isModify: true,
        );

        if (result['status'] == 'success') {
          // ~:Emit success state with user data:~
          emit(SalesmanStatusModified('Data successfully updated'));
        } else {
          emit(SalesmanStatusModifyError(result['data'] as String));
        }
      } else {
        emit(SalesmanStatusModifyError('User credentials not found'));
      }
    } catch (e) {
      log('Error: ${e.toString()}');
      emit(
        SalesmanStatusModifyError(
          'Failed to modify salesman status: ${e.toString()}',
        ),
      );
    }
  }
}
