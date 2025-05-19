import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sop_mobile/presentation/state/photo/photo_event.dart';
import 'package:sop_mobile/presentation/state/photo/photo_state.dart';

class PhotoBloc<BaseEvent, BaseState> extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial()) {
    on<InitPhotoEvent>(initPhotoHandler);
    on<CheckCameraPermission>(checkCameraPermission);
    on<UploadPhotoEvent>(uploadPhotoHandler);
    on<DeletePhotoEvent>(deletePhotoHandler);
    on<RemovePhotoEvent>(removePhotoHandler);
  }

  Future<void> initPhotoHandler(
    InitPhotoEvent event,
    Emitter<PhotoState> emit,
  ) async {
    // ~:Network Call Simulation:~
    emit(PhotoInitial());
  }

  Future<void> checkCameraPermission(
    CheckCameraPermission event,
    Emitter<PhotoState> emit,
  ) async {
    try {
      // ~:Network Call Simulation:~
      if (event.permissionStatus.isGranted ||
          event.permissionStatus.isLimited) {
        emit(PhotoPermissionGranted(event.permissionStatus));
      } else {
        emit(PhotoPermissionDenied(event.permissionStatus));
      }
    } catch (e) {
      emit(PhotoPermissionError(e.toString()));
    }
  }

  Future<void> removePhotoHandler(
    RemovePhotoEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());
    try {
      // ~:Network Call Simulation:~
      emit(PhotoInitial());
      emit(PhotoDeleteSuccess());

      // ~:Unit Test not passed yet:~
      // source code...
    } catch (e) {
      emit(PhotoDeleteFail(e.toString()));
    }
  }

  Future<void> uploadPhotoHandler(
    UploadPhotoEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());
    try {
      // ~:Image Picker Simulation:~
      XFile? imgPicker =
          await ImagePicker().pickImage(source: ImageSource.camera);

      // ~:Unit Test Passed:~
      // Map<String, dynamic> response = await photoRepo!
      //     .uploadPhoto(event.photoPath);

      emit(PhotoLoading());

      Uint8List? imgBytes;
      Image? image;
      String photoUrl = '';
      if (imgPicker != null) {
        imgBytes = await imgPicker.readAsBytes();
      } else {
        emit(PhotoUploadFail('Image not selected'));
      }

      if (imgBytes != null) {
        image = decodeImage(imgBytes);
      } else {
        emit(PhotoUploadFail('Image decode failed'));
      }

      if (image != null) {
        photoUrl = base64Encode(encodePng(image));
      } else {
        emit(PhotoUploadFail('Image encode failed'));
      }

      if (photoUrl.isNotEmpty) {
        emit(PhotoUploadSuccess(photoUrl));
      } else {
        emit(PhotoUploadFail('Image upload failed'));
      }
    } catch (e) {
      emit(PhotoUploadFail(e.toString()));
    }
  }

  Future<void> deletePhotoHandler(
    DeletePhotoEvent event,
    Emitter<PhotoState> emit,
  ) async {
    emit(PhotoLoading());
    try {
      // ~:Network Call Simulation:~
      emit(PhotoInitial());
      emit(PhotoDeleteSuccess());

      // ~:Unit Test not passed yet:~
      // source code...
    } catch (e) {
      emit(PhotoDeleteFail(e.toString()));
    }
  }
}
