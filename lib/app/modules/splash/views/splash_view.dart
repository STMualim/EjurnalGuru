import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetBuilder<SplashController>(
      builder: (controller) => Scaffold(
        body: Container(
          color: Color.fromARGB(255, 5, 61, 107),
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
                width: 150,
              ),
              // Spacer(),
              Text(
                'Guru e-Jurnal',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'poppins',
                    color: Colors.white),
              ),
              Text(
                'Aplikasi Catatan Kegiatan Guru',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'v.1.0 \u00A9 2023',
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
