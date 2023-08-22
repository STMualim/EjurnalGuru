import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    // TextEditingController userInput = TextEditingController();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /* appBar: AppBar(
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
                      child: Text(
                        'Registrasi Akun Baru',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            color: Color.fromARGB(235, 66, 66, 66)),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      // key: _formKey,
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        // controller: userInput,
                        controller: controller.idNoC,
                        decoration: InputDecoration(
                          labelText: "NIP/NUPTK",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: controller.nameC,
                        decoration: InputDecoration(
                          labelText: "Nama Lengkap",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: controller.emailC,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle:
                              TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                        ),
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
                          controller: controller.passC,
                          obscureText: controller.obsecureText.value,

                          decoration: InputDecoration(
                            labelText: "Password",
                            hintText: "*******",
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
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
                          ),

                          // obscureText: true,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: Obx(
                        () => TextFormField(
                          controller: controller.uPassC,
                          obscureText: controller.obsecureText_1.value,

                          decoration: InputDecoration(
                            labelText: "Ulangi Password",
                            hintText: "*******",
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            suffixIcon: IconButton(
                              icon: (controller.obsecureText_1 != false)
                                  ? SvgPicture.asset('assets/icons/show.svg')
                                  : SvgPicture.asset('assets/icons/hide.svg'),
                              onPressed: () {
                                controller.obsecureText_1.value =
                                    !(controller.obsecureText_1.value);
                              },
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),

                          // obscureText: true,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    InkWell(
                      child: Obx(
                        () => ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(4, 98, 230, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              minimumSize: Size(200, 45)),
                          onPressed: () async {
                            if (controller.isLoading.isFalse) {
                              await controller.registration();
                            }
                          },
                          child: Text(
                            (controller.isLoading.isFalse)
                                ? 'DAFTAR'
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
                            'Sudah punya akun? ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Color.fromARGB(255, 49, 48, 48),
                            ),
                          ),
                          InkWell(
                            onTap: () => {
                              Get.offNamed(Routes.LOGIN),
                            },
                            child: Text(
                              'Login !',
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
