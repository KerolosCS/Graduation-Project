// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
part 'getvideo_state.dart';

class GetvideoCubit extends Cubit<GetvideoState> {
  GetvideoCubit() : super(GetvideoFail());

  VideoPlayerController? controller;
  final ImagePicker picker = ImagePicker();
  Future getVideoFromGallery() async {
    controller?.dispose();
    XFile? file;
    print("function one");
    file = await picker.pickVideo(
        source: ImageSource.gallery, maxDuration: const Duration(seconds: 2));
    if (file != null &&
        controller!.value.duration <= const Duration(seconds: 2)) {
      controller = VideoPlayerController.file(
        File(file.path),
      )..initialize();

      emit(GetvideoSucces());
    } else {
      emit(GetvideoFail());
      print("NULL");
    }
  }

  //Image Picker function to get image from camera
  Future getVideoFromCameraOneSecond() async {
    print("function two");
    XFile? file;
    controller?.dispose();

    file = await picker.pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(seconds: 1));
    if (file != null) {
      controller = VideoPlayerController.file(
        File(file.path),
      )..initialize();

      emit(GetvideoSucces());
    } else {
      emit(GetvideoFail());
      print("NULL");
    }
  }

  Future getVideoFromCameraTwoSecond() async {
    print("function three");
    XFile? file;
    controller?.dispose();
    file = await picker.pickVideo(
        source: ImageSource.camera, maxDuration: const Duration(seconds: 2));
    if (file != null) {
      controller = VideoPlayerController.file(
        File(file.path),
      )..initialize();

      emit(GetvideoSucces());
    } else {
      emit(GetvideoFail());
      print("NULL");
    }
  }

  void justState() {
    emit(ChangeView());
  }
}
