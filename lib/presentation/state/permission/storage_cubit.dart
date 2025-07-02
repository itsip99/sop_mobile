import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageCubit extends Cubit<PermissionStatus> {
  StorageCubit() : super(PermissionStatus.denied);

  Future<void> checkStoragePermission() async {
    final status = await Permission.storage.status;
    emit(status);
  }

  Future<void> requestStoragePermission() async {
    final status = await Permission.storage.request();
    emit(status);
  }
}
