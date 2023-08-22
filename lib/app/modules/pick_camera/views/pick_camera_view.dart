import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pick_camera_controller.dart';

class PickCameraView extends GetView<PickCameraController> {
  const PickCameraView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CameraCamera(onFile: (file) => Get.back(result: file)));
  }
}
