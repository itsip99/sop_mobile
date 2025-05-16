import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraCubit extends Cubit<PermissionStatus> {
  CameraCubit() : super(PermissionStatus.denied);

  Future<void> checkCameraPermission() async {
    final status = await Permission.camera.status;
    emit(status);
  }

  Future<void> requestCameraPermission() async {
    final status = await Permission.camera.request();
    emit(status);
  }
}
