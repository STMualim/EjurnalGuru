import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      /* appBar: AppBar(
        title: const Text(
          'Guru e-Jurnal',
          // style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 5, 61, 107),
      ), */
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              case ConnectionState.active:
              case ConnectionState.done:
                Map<String, dynamic> user = snapshot.data!.data()!;

                return Container(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 15),
                                      child: Image.asset(
                                        'assets/images/usr.png',
                                        width: 50,
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 15, right: 10),
                                          child: Text(
                                            "Selamat Datang,\n${user['name']}",
                                            style: TextStyle(fontSize: 16),
                                          )),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 30, top: 40),
                                  child: Text(
                                    'Jurnalku',
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
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 235, 13, 154),
                                              fixedSize: const Size(400, 60)),
                                          onPressed: () => {
                                            Get.toNamed(Routes.INPUT),
                                          },
                                          label: Text(
                                            "Input Jurnal",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          icon: Icon(
                                            Icons.article_rounded,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                      InkWell(
                                        child: ElevatedButton.icon(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              backgroundColor: Color.fromARGB(
                                                  255, 132, 11, 237),
                                              fixedSize: const Size(400, 60)),
                                          onPressed: () => {
                                            Get.toNamed(Routes.RIWAYAT),
                                          },
                                          label: Text(
                                            "Riwayat Jurnal",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          icon: Icon(
                                            Icons.auto_mode_rounded,
                                            size: 40,
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
                      ),
                    ],
                  ),
                );
              default:
                return Text("error");
            }
          }),
    );
  }
}
