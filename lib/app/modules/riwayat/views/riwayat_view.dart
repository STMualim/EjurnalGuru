import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:guru_ejurnal/firebase_options.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/app_color.dart';
import '../controllers/riwayat_controller.dart';

class RiwayatView extends GetView<RiwayatController> {
  const RiwayatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    Get.put(RiwayatController());
    WidgetsFlutterBinding.ensureInitialized();

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
                  // height: size.height,
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
                        height: size.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'Riwayat Jurnal',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 66, 60, 60),
                              fontFamily: 'Poppins'),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 4, right: 4),
                              child: SizedBox(
                                height: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.83,
                                      child: Container(
                                        padding:
                                            EdgeInsets.only(left: 5, right: 5),
                                        decoration: BoxDecoration(
                                            // color: Colors.yellow,
                                            // Red border with the width is equal to 5
                                            border: Border.all(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    156, 96, 96, 96)),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Get.dialog(
                                                  Dialog(
                                                    child: Container(
                                                      height: 372,
                                                      child: SfDateRangePicker(
                                                        headerHeight: 50,
                                                        headerStyle:
                                                            DateRangePickerHeaderStyle(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center),
                                                        monthViewSettings:
                                                            DateRangePickerMonthViewSettings(
                                                                firstDayOfWeek:
                                                                    1),
                                                        selectionMode:
                                                            DateRangePickerSelectionMode
                                                                .range,
                                                        selectionColor:
                                                            AppColor.primary,
                                                        rangeSelectionColor:
                                                            AppColor.primary
                                                                .withOpacity(
                                                                    0.2),
                                                        viewSpacing: 10,
                                                        showActionButtons: true,
                                                        onCancel: () =>
                                                            Get.back(),
                                                        onSubmit: (data) {
                                                          if (data != null) {
                                                            PickerDateRange
                                                                range = data
                                                                    as PickerDateRange;
                                                            if (range.endDate !=
                                                                null) {
                                                              controller.pickDate(
                                                                  range
                                                                      .startDate!,
                                                                  range
                                                                      .endDate!);
                                                            }
                                                          }
                                                          //else skip
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Text("Rentang Tanggal"),
                                              // child: SvgPicture.asset(
                                              //     'assets/icons/filter.svg'),

                                              style: ElevatedButton.styleFrom(
                                                minimumSize: Size(150, 40),
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 255, 143, 7),
                                                elevation: 0,
                                                padding: EdgeInsets.zero,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GetBuilder<RiwayatController>(
                                                    builder: (controller) {
                                                  return Text((controller
                                                              .start !=
                                                          null)
                                                      ? DateFormat('dd/MM/yyyy')
                                                              .format(controller
                                                                  .start!)
                                                              .toString() +
                                                          " - " +
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(controller
                                                                  .end)
                                                              .toString()
                                                      : '');
                                                }),
                                              ],
                                            ),
                                            ElevatedButton.icon(
                                              // <-- ElevatedButton
                                              onPressed: () {
                                                controller.exportDataToExcel();
                                              },
                                              icon: Icon(
                                                Icons.download,
                                                size: 30.0,
                                              ),
                                              label: Text('Unduh Jurnal'),
                                              style: ElevatedButton.styleFrom(
                                                  // minimumSize: Size(200, 40),
                                                  primary: Color.fromARGB(
                                                      255, 33, 117, 243),
                                                  fixedSize: const Size(200,
                                                      40) // Background color
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03),
                            SizedBox(
                              height: 400, // constrain height
                              child: GetBuilder<RiwayatController>(
                                  builder: (context) {
                                return StreamBuilder<QuerySnapshot>(
                                  stream: controller.getAllResult(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return const Text('Error');
                                    }
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Text("Loading...");
                                    }
                                    var datas = snapshot.data!.docs;
                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: datas.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Map<String, dynamic> data = datas[index]
                                            .data()! as Map<String, dynamic>;
                                        // int konversi = data["tanggal"];
                                        DateTime tgl =
                                            DateTime.parse(data["tanggal"]);
                                        String konversi =
                                            DateFormat('dd/MM/yyyy')
                                                .format(tgl);

                                        return Card(
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 10,
                                                  ),
                                                  child: ListTile(
                                                    // leading: Image.asset(
                                                    //     'assets/images/sample.png'),
                                                    leading: SizedBox(
                                                      height: 100,
                                                      width: 100,
                                                      child: Image.network(
                                                        data["foto"],
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    title: Text(
                                                      // data["tanggal"],
                                                      konversi,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    subtitle: Text("KBM : " +
                                                        data['kbm'] +
                                                        "\n\n" +
                                                        "Non KBM : " +
                                                        data['non_kbm']),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.edit_document,
                                                          color: Color.fromRGBO(
                                                              7,
                                                              187,
                                                              118,
                                                              0.98),
                                                        ),
                                                        tooltip: 'Edit Jurnal',
                                                        onPressed: () {
                                                          Get.toNamed(
                                                              Routes
                                                                  .EDIT_JURNAL,
                                                              arguments: data);
                                                        },
                                                        iconSize: 30,
                                                      ),
                                                      SizedBox(width: 8),
                                                      IconButton(
                                                        icon: const Icon(
                                                          Icons.delete_rounded,
                                                          color: Color.fromARGB(
                                                              255, 255, 42, 92),
                                                        ),
                                                        tooltip: 'Hapus Jurnal',
                                                        onPressed: () {
                                                          controller
                                                              .deleteJurnal(data[
                                                                  "jurnal_id"]);
                                                        },
                                                        iconSize: 30,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                      )
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
