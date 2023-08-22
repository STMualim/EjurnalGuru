import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:guru_ejurnal/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /*  appBar: AppBar(
        title: const Text('Guru e-Jurnal'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 5, 61, 107),
      ), */
      // backgroundColor: Color.fromARGB(255, 5, 61, 107),
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/images/h1.png"),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/images/h2.png"),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset("assets/images/f1.png", width: size.width),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset("assets/images/f2.png", width: size.width),
            ),
            SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/usr.png',
                        width: 100,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Column(
                        children: [
                          Text(
                            'Guru e-Jurnal',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(235, 66, 66, 66)),
                          ),
                          Text(
                            'Aplikasi Catatan Kegiatan Guru',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Color.fromARGB(235, 66, 66, 66)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(),
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(17, 209, 120, 1))),
                        ),
                        controller: controller.emailC,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Obx(
                        () => TextField(
                          obscureText: controller.obsecureText.value,
                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "*******",
                            prefixIcon: const Icon(
                              Icons.lock_outline_rounded,
                              color: Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: (controller.obsecureText != false)
                                  ? SvgPicture.asset('assets/icons/show.svg')
                                  : SvgPicture.asset('assets/icons/hide.svg'),
                              onPressed: () {
                                controller.obsecureText.value =
                                    !(controller.obsecureText.value);
                              },
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          controller: controller.passC,

                          // obscureText: true,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: InkWell(
                        onTap: () => {
                          Get.toNamed(Routes.RESET_PASS),
                        },
                        child: Text(
                          'Lupa Password?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(255, 49, 48, 48),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    InkWell(
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(17, 209, 120, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: const Size(200, 45)),
                          onPressed: () async {
                            if (controller.isLoading.isFalse) {
                              await controller.login();
                            }
                          },
                          child: Text(
                            (controller.isLoading.isFalse)
                                ? 'LOGIN'
                                : 'Loading...',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Belum punya akun? ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 49, 48, 48),
                            ),
                          ),
                          InkWell(
                            onTap: () => {
                              Get.offAllNamed(Routes.REGISTER),
                            },
                            child: Text(
                              'Buat Akun!',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color.fromARGB(255, 21, 112, 248),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
