import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/input_controller.dart';

class InputView extends GetView<InputController> {
  const InputView({Key? key}) : super(key: key);
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
                  padding: EdgeInsets.only(top: 20, bottom: 20),
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
                        height: size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'Input Jurnal',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 66, 60, 60),
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.dateInput,
                          decoration: InputDecoration(
                            labelText: "Tanggal",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                          // readOnly: true,
                          onTap: () async {
                            // focusSCope memberikan efek fokus di isian tanggal,menyembunyikan keyboard dan dialog tanggal tidak akan bergerak-gerak
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(
                                  1900), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              //membuat variabel formatteddate yang akan tampil pada isian tanggal
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              controller.dateInput.text =
                                  formattedDate; //set output date to TextField value.
                              // mengisi variabel date yang akan disimpan ke firebase dengan nilai seperti pickedDate
                              controller.date = pickedDate;
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.jam_keC,
                          decoration: InputDecoration(
                            labelText: "Jam Ke",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.kelasC,
                          decoration: InputDecoration(
                            labelText: "Kelas",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.mapelC,
                          decoration: InputDecoration(
                            labelText: "Mapel",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.kdC,
                          decoration: InputDecoration(
                            labelText: "Kompetensi Dasar",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          maxLines: 2,
                          controller: controller.kbmC,
                          decoration: InputDecoration(
                            labelText: "Uraian Kegiatan KBM",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextFormField(
                          controller: controller.non_kbmC,
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: "Uraian Kegiatan Non KBM",
                            border: OutlineInputBorder(),
                            labelStyle:
                                TextStyle(color: Color.fromRGBO(63, 63, 63, 1)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(17, 209, 120, 1))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.015,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            // color: Colors.yellow,
                            // Red border with the width is equal to 5
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(156, 96, 96, 96)),
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: GetBuilder<InputController>(
                                  builder: (context) {
                                if (controller.file != null) {
                                  return Image.file(
                                    controller.file!,
                                    width: 300,
                                  );
                                } else {
                                  return Text(
                                    'tidak ada gambar',
                                    style: TextStyle(fontSize: 16),
                                  );
                                }
                              }),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => controller.toCamera(),
                              label: Text("Ambil Gambar"),
                              icon: Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromRGBO(17, 209, 120, 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    minimumSize: Size(200, 45)),
                                onPressed: () async {
                                  if (controller.isLoading.isFalse) {
                                    await controller.inputJurnal();
                                  }
                                },
                                child: Text(
                                  (controller.isLoading.isFalse)
                                      ? 'SIMPAN'
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
