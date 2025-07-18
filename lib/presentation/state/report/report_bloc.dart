import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/data/models/user.dart';
import 'package:sop_mobile/domain/repositories/report.dart';
import 'package:sop_mobile/domain/repositories/storage.dart';
import 'package:sop_mobile/presentation/state/report/report_event.dart';
import 'package:sop_mobile/presentation/state/report/report_state.dart';

class ReportBloc<BaseEvent, BaseState> extends Bloc<ReportEvent, ReportState> {
  final ReportRepo reportRepo;
  final StorageRepo storageRepo;

  ReportBloc({required this.reportRepo, required this.storageRepo})
    : super(ReportInitial('')) {
    on<InitiateReport>((event, emit) => emit(ReportInitial('')));
    on<CreateReport>(onCreateReport);
  }

  Future<void> onCreateReport(
    CreateReport event,
    Emitter<ReportState> emit,
  ) async {
    // ~:Emit loading state:~
    emit(ReportLoading('Creating report...'));

    // ~:Declare local variables for this function:~
    Map<String, dynamic> basicReport = {};
    List<Map<String, dynamic>> reportSTU = [];
    List<Map<String, dynamic>> reportPayment = [];
    List<Map<String, dynamic>> reportLeasing = [];
    List<Map<String, dynamic>> reportSalesman = [];
    bool isStuSuccess = false;
    bool isPaymentSuccess = false;
    bool isLeasingSuccess = false;
    bool isSalesmanSuccess = false;

    // ~:Secure Storage Simulation:~
    UserCredsModel userCreds = await storageRepo.getUserCredentials();
    // String branchArea = ;

    // ~:Get User Credentials:~
    if (userCreds.username == '') {
      emit(ReportCreationError('Informasi pengguna tidak ditemukan.'));
      return; // Exit current function if no user credentials
    }

    // ~:Basic Report Data Creation:~
    if (event.dealerName.isEmpty ||
        event.areaName.isEmpty ||
        event.personInCharge.isEmpty) {
      log('Empty fields');
      emit(ReportCreationWarning('Kolom PIC wajib diisi.'));
      return; // Exit current function if required fields are empty
    } else {
      basicReport = await reportRepo.createBasicReport(
        userCreds.username,
        DateTime.now().toIso8601String().substring(0, 10),
        event.dealerName,
        event.areaName,
        event.personInCharge,
      );
    }

    // ~:Report STU Data Creation:~
    log('STU Data: ${event.stuData.length}');
    if (event.stuData.isEmpty) {
      emit(ReportCreationWarning('Data STU tidak ditemukan.'));
      return; // Exit current function if required fields are empty
    } else {
      for (int i = 0; i < event.stuData.length; i++) {
        reportSTU.add(
          await reportRepo.createReportSTU(
            userCreds.username,
            DateTime.now().toIso8601String().substring(0, 10),
            event.stuData[i],
            i + 1,
          ),
        );
      }

      isStuSuccess = reportSTU.every((item) => item['status'] == 'success');
      log('STU Success: $isStuSuccess');
      if (!isStuSuccess) {
        log('Gagal membuat semua laporan STU.');
        emit(ReportCreationError('Gagal membuat laporan STU.'));
        return;
      }
    }

    // ~:Report Payment Data Creation:~
    if (event.paymentData.isEmpty) {
      emit(ReportCreationWarning('Data Payment tidak ditemukan.'));
      return; // Exit current function if required fields are empty
    } else {
      for (int i = 0; i < event.paymentData.length; i++) {
        reportPayment.add(
          await reportRepo.createReportPayment(
            userCreds.username,
            DateTime.now().toIso8601String().substring(0, 10),
            event.paymentData[i],
            i + 1,
          ),
        );
      }

      isPaymentSuccess = reportPayment.every(
        (item) => item['status'] == 'success',
      );
      if (!isPaymentSuccess) {
        log('Gagal membuat semua laporan Payment.');
        emit(ReportCreationError('Gagal membuat laporan Payment.'));
        return;
      }
    }

    // ~:Report Leasing Data Creation:~
    if (event.leasingData.isEmpty) {
      emit(ReportCreationWarning('Data Leasing tidak ditemukan.'));
      return; // Exit current function if required fields are empty
    } else {
      for (int i = 0; i < event.leasingData.length; i++) {
        reportLeasing.add(
          await reportRepo.createReportLeasing(
            userCreds.username,
            DateTime.now().toIso8601String().substring(0, 10),
            event.leasingData[i],
            i + 1,
          ),
        );
      }

      isLeasingSuccess = reportLeasing.every(
        (item) => item['status'] == 'success',
      );
      if (!isLeasingSuccess) {
        emit(ReportCreationError('Gagal membuat laporan Leasing.'));
        return;
      }
    }

    // ~:Report Salesman Data Creation:~salesmanData
    try {
      if (event.salesmanData.isEmpty) {
        emit(ReportCreationWarning('Data Salesman tidak ditemukan.'));
        return; // Exit current function if required fields are empty
      } else {
        for (int i = 0; i < event.salesmanData.length; i++) {
          reportSalesman.add(
            await reportRepo.createReportSalesman(
              event.salesData
                  .where((e) => e.userName == event.salesmanData[i].name)
                  .first
                  .id,
              userCreds.username,
              DateTime.now().toIso8601String().substring(0, 10),
              event.salesmanData[i],
              i + 1,
            ),
          );
        }

        isSalesmanSuccess = reportSalesman.every(
          (item) => item['status'] == 'success',
        );
        if (!isSalesmanSuccess) {
          emit(ReportCreationError('Gagal membuat laporan Salesman.'));
          return;
        }
      }
    } catch (e) {
      if (event.salesmanData.isEmpty) {
        emit(ReportCreationWarning('Data Salesman tidak ditemukan.'));
        return;
      } else {
        emit(ReportCreationError('Gagal membuat laporan Salesman.'));
        return;
      }
    }

    // ~:Emit success state with all report data:~
    if (basicReport['status'] == 'success' &&
        isStuSuccess &&
        isPaymentSuccess &&
        isLeasingSuccess &&
        isSalesmanSuccess) {
      emit(ReportCreationSuccess('Laporan berhasil dibuat.'));
    } else {
      emit(ReportCreationError('Gagal membuat laporan.'));
    }
  }
}
