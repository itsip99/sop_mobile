import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageCubit extends Cubit<PermissionStatus> {
  StorageCubit() : super(PermissionStatus.denied);

  Future<PermissionStatus> askStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) {
      status = await Permission.storage.request();
    }
    emit(status);
    return status;
  }
}
