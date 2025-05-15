import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sop_mobile/presentation/state/photo/photo_event.dart';
import 'package:sop_mobile/presentation/state/photo/photo_state.dart';

class PhotoBloc<BaseEvent, BaseState> extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc() : super(PhotoInitial()) {
    on<UploadPhotoEvent>(uploadPhotoHandler);
    on<DeletePhotoEvent>(deletePhotoHandler);
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
        return;
      }

      if (imgBytes != null) {
        image = decodeImage(imgBytes);
      } else {
        emit(PhotoUploadFail('Image decode failed'));
        return;
      }

      if (image != null) {
        photoUrl = base64Encode(encodePng(image));
      } else {
        emit(PhotoUploadFail('Image encode failed'));
        return;
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
