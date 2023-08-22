import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/profil_controller.dart';

class ProfilView extends GetView<ProfilController> {
  ProfilView({Key? key}) : super(key: key);
  final controller = Get.put(ProfilController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset("assets/images/h3.png"),
            ),
            SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  height: size.height,
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 15),
                            child: Image.asset(
                              'assets/images/usr.png',
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30, top: 30),
                        child: Text(
                          'Profil',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 66, 60, 60),
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Container(
                        // key: _formKey,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.idNoC,
                          // initialValue: "324776366520",
                          // controller:
                          //     TextEditingController(text: "324776366520"),
                          decoration: InputDecoration(
                            labelText: "NIP/NUPTK",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(209, 84, 17, 1))),
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
                      SizedBox(height: size.height * 0.015),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.nameC,
                          // initialValue: "Nama Saya",
                          decoration: InputDecoration(
                            labelText: "Nama Lengkap",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(209, 84, 17, 1))),
                          ),
                          // readOnly: true,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.emailC,
                          // initialValue: "a@a.com",
                          decoration: InputDecoration(
                            labelText: "Email",
                            fillColor: Color.fromARGB(97, 105, 105, 105),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(64, 64, 64, 1))),
                          ),
                          readOnly: true,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      /* SizedBox(height: size.height * 0.015),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          initialValue: "******",
                          // controller: controller.passC,
                          decoration: InputDecoration(
                            labelText: "Password",
                            fillColor: Color.fromARGB(97, 105, 105, 105),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(209, 84, 17, 1))),
                          ),
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.015),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          initialValue: "******",
                          decoration: InputDecoration(
                            labelText: "Ulangi Password",
                            fillColor: Color.fromARGB(97, 105, 105, 105),
                            filled: true,
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(209, 84, 17, 1))),
                          ),
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ), */
                      SizedBox(height: size.height * 0.03),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => InkWell(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(230, 131, 9, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    minimumSize: Size(200, 45)),
                                onPressed: () async {
                                  if (controller.isLoading.isFalse) {
                                    await controller.editProfil();
                                  }
                                },
                                child: Text(
                                  (controller.isLoading.isFalse)
                                      ? 'UPDATE DATA'
                                      : 'Loading...',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
