import 'package:altunbasakadmin/modules/addHomePostingScreen/add_home_posting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddHomePostingController controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "İlan Adresi Ekle",
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
          padding: EdgeInsets.only(top: 35),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() {
                  return TextField(
                    minLines: 1,
                    maxLines: 2,
                    controller: controller.addressController.value,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Bounceable(
                          onTap: () {
                            if (controller
                                .addressController.value.text.isEmpty) {
                              Get.snackbar("Bulunamadı",
                                  "Lütfen Adres Bilgisini Giriniz",
                                  titleText: Text(
                                    "Bulunamadı",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Sf Pro",
                                      color: Color(0xffD45E39),
                                    ),
                                  ),
                                  messageText: Text(
                                    "Lütfen Adres Bilgisini Giriniz",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Sf Pro",
                                      color: Color(0xff232455),
                                    ),
                                  ),
                                  backgroundColor: Colors.white);
                            } else {
                              controller.moveToAdress(
                                  controller.addressController.value.text);
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 70,
                            decoration: BoxDecoration(
                                color: Color(0xffD45E39),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              "Ara",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffF3F3F3),
                                  fontFamily: "Sf Pro"),
                            )),
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      labelText: 'Adres Girin',
                      border: OutlineInputBorder(),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: Obx(() {
                  return GoogleMap(
                    onTap: controller.onMapTap,
                    onMapCreated: controller.onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(38.963745, 35.243320),
                      zoom: 1,
                    ),
                    markers:
                        Set<Marker>.of(controller.selectedLocation.value == null
                            ? []
                            : [
                                Marker(
                                    markerId: MarkerId("Seçilen Adres"),
                                    position:
                                        controller.selectedLocation.value!)
                              ]),
                  );
                }),
              ),
            ],
          ),
        ));
  }
}
