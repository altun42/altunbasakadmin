import 'package:altunbasakadmin/modules/homeScreen/home_screen_controller.dart';
import 'package:altunbasakadmin/routes/app_pages.dart';
import 'package:altunbasakadmin/shared/constants/data_model.dart';
import 'package:altunbasakadmin/shared/constants/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends GetView<HomescreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "İlanlarım",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: "Sf Pro"),
        ),
        backgroundColor: Color(0xff232455),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xff232455),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30, right: 12, left: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Bounceable(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color(0xffD45E39),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "İlan Düzenleme",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffF3F3F3),
                            fontFamily: "Sf Pro"),
                      ),
                    ),
                  ),
                ),
                Bounceable(
                  onTap: () {},
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color(0xffD45E39),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "İlan Silme",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffF3F3F3),
                            fontFamily: "Sf Pro"),
                      ),
                    ),
                  ),
                ),
                Bounceable(
                  onTap: () {
                    Get.toNamed(Routes.ADDHOMEPOSTING);
                  },
                  child: Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color(0xffD45E39),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "İlan Ekleme",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffF3F3F3),
                            fontFamily: "Sf Pro"),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<List<Data>>(
              stream: FirestoreService().getStreamData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: EdgeInsets.only(top: 22.h),
                    child: const Center(
                        child: CircularProgressIndicator(
                      color: Color(0xff232455),
                    )),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("Bir Hata Oluştu"),
                  );
                }

                return Obx(
                  () {
                    return controller.items.isNotEmpty
                        ? Expanded(child: Obx(() {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.dataList.length,
                              itemBuilder: (context, index) {
                                return AdsCard(
                                    path: controller.items[0],
                                    ilanTipi:
                                        controller.dataList[index].ilanTipi,
                                    il: controller.dataList[index].il,
                                    ilce: controller.dataList[index].ilce,
                                    ilanNo: controller.dataList[index].ilanNo,
                                    fiyat: controller.dataList[index].fiyat);
                              },
                            );
                          }))
                        : SizedBox();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AdsCard extends StatelessWidget {
  const AdsCard({
    super.key,
    required this.ilanTipi,
    required this.il,
    required this.ilce,
    required this.ilanNo,
    required this.fiyat,
    required this.path,
  });
  final String ilanTipi;
  final String il;
  final String ilce;
  final String ilanNo;
  final String fiyat;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Bounceable(
        onTap: () {},
        child: Container(
          width: 350,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 35, left: 10),
                child: Container(
                    height: 100,
                    width: 130,
                    child: Image.network(
                      path,
                      fit: BoxFit.fill,
                    )),
              ),
              SizedBox(
                width: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ilanTipi,
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xff232455),
                          fontFamily: "Sf Pro"),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${il}/${ilce}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                          fontFamily: "Sf Pro"),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      fiyat,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontFamily: "Sf Pro"),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "İlan No:$ilanNo",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: "Sf Pro"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
