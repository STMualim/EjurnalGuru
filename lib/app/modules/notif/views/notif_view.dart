import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/notif_controller.dart';

class NotifView extends GetView<NotifController> {
  const NotifView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var format = new DateFormat('dd-mm-yyyy');
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    Size size = MediaQuery.of(context).size;
    Get.put(NotifController());
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
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'Pemberitahuan',
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
                            SizedBox(
                              height: 450,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: controller.streamNotif(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Text('Error');
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Text("Loading...");
                                  }
                                  return ListView(
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    Timestamp ts = data['date'];
                                    DateTime dateTime = ts.toDate();
                                    String st =
                                        '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                                    return ListTile(
                                      trailing: Text(
                                        st,
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 189, 8, 65)),
                                      ),
                                      title: Text(data['desc']),
                                    );
                                  }).toList());
                                },
                              ),
                            ),
                            /* SizedBox(
                              height: 450, // constrain height
                              child: ListView.separated(
                                scrollDirection: Axis.vertical,
                                itemCount: 10,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      trailing: Text(
                                        "$index Agustus 2023",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 189, 8, 65)),
                                      ),
                                      title: Text(
                                          'Assalamualaikum Bapak Ibu Guru yang hebat ini pemberitahuan ke $index'));
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                              ),
                            ) */
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
