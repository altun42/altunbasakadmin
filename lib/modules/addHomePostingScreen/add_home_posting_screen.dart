import 'dart:async';
import 'dart:io';

import 'package:altunbasakadmin/modules/addHomePostingScreen/add_home_posting_controller.dart';
import 'package:altunbasakadmin/modules/addHomePostingScreen/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

class AddHomePostingScreen extends GetView<AddHomePostingController> {
  const AddHomePostingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    Get.put(AddHomePostingController);
    return Scaffold(
      backgroundColor: Color(0xfff3f3f3),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "İlan Ekle",
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
        padding: EdgeInsets.only(top: 30, right: 15, left: 15),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return Container(
                    height: 300,
                    width: 350,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: controller.photoss.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5),
                              itemCount: controller.photoss.length,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                          color: Color(0xfff3f3f3),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Image.file(
                                          File(controller.photoss[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Bounceable(
                                        onTap: () {
                                          controller.removeImage(index);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              "İlan Fotoğraflarını Giriniz...",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 128, 126, 126),
                                  fontFamily: "Sf Pro",
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                  );
                }),
                SizedBox(
                  height: 3.h,
                ),
                Bounceable(
                  onTap: () {
                    controller.pickImages();
                  },
                  child: Container(
                    height: 50,
                    width: 358,
                    decoration: BoxDecoration(
                        color: Color(0xffD45E39),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "Galeriden Fotoğraf Seç",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffF3F3F3),
                          fontFamily: "Sf Pro"),
                    )),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "İlan Bilgileri Ekle",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Sf Pro",
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 128, 126, 126)),
                    ),
                    Bounceable(
                      onTap: () {
                        if (controller.isSee.value == true) {
                          controller.isSee.value = false;
                        } else {
                          controller.isSee.value = true;
                        }
                      },
                      child: Icon(Icons.arrow_drop_down_circle),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Obx(() {
                  return controller.isSee.value == true
                      ? Column(
                          children: [
                            AdvertInfoTextField(
                              label: "İlan Başlığı Giriniz (Zorunlu)",
                              type: TextInputType.text,
                              controller: controller.ilanBasligi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "İlan Tipi",
                              type: TextInputType.text,
                              controller: controller.ilanTipi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "İlan No (Zorunlu)",
                              type: TextInputType.number,
                              controller: controller.ilanNo,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "İlan Tarihi",
                              type: TextInputType.datetime,
                              controller: controller.ilanTarihi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Konut Şekli",
                              type: TextInputType.name,
                              controller: controller.konutSekli,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Oda Sayısı",
                              type: TextInputType.text,
                              controller: controller.odaSayisi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Banyo Sayısı",
                              type: TextInputType.number,
                              controller: controller.banyoSayisi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Metrekare",
                              type: TextInputType.text,
                              controller: controller.metreKare,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Binanın Yaşı",
                              type: TextInputType.number,
                              controller: controller.binaninYasi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Binadaki Kat Sayısı",
                              type: TextInputType.number,
                              controller: controller.kat,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Bulunduğu Kat",
                              type: TextInputType.number,
                              controller: controller.bulunduguKat,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Isınma Tipi",
                              type: TextInputType.name,
                              controller: controller.isinmaTipi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Yakıt Tipi",
                              type: TextInputType.name,
                              controller: controller.yakitTipi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Yapı Tipi",
                              type: TextInputType.name,
                              controller: controller.yapitipi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Yapının Durumu",
                              type: TextInputType.name,
                              controller: controller.yapininDurumu,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Kullanım Durumu",
                              type: TextInputType.name,
                              controller: controller.kullanimDurumu,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Krediye Uygunluk",
                              type: TextInputType.name,
                              controller: controller.krediyeUygunluk,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Aidat",
                              type: TextInputType.text,
                              controller: controller.aidat,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Takas",
                              type: TextInputType.name,
                              controller: controller.takas,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Cephe Seçenekleri",
                              type: TextInputType.name,
                              controller: controller.cepheSecenekleri,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Kira Getirisi",
                              type: TextInputType.text,
                              controller: controller.kiraGetirisi,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Fiyat",
                              type: TextInputType.text,
                              controller: controller.ilanFiyat,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            AdvertInfoTextField(
                              label: "Site İçerisinde",
                              type: TextInputType.name,
                              controller: controller.siteIcerisinde,
                            ),
                            SizedBox(
                              height: 17,
                            ),
                            TextFormField(
                              controller: controller.aciklama,
                              minLines: 1,
                              maxLines: 10,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xff232455),
                                    )),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      width: 2,
                                      color: Color(0xffD45E39),
                                    )),
                                filled: true,
                                fillColor: Colors.white,
                                label: Text(
                                  "Açıklama",
                                  style: TextStyle(
                                      color: Color(0xff232455), fontSize: 20),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox();
                }),
                SizedBox(
                  height: 17,
                ),
                Bounceable(
                  onTap: () {
                    // controller.moveToAdress(controller.addressController.text);
                    Get.to(
                      MapScreen(),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Color(0xff232455),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "İlan Adresi Ekle",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffF3F3F3),
                          fontFamily: "Sf Pro"),
                    )),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 20,
                ),
                Bounceable(
                  onTap: () {
                    controller.createHomeAd(
                      adress: controller.addressController.value.text,
                      ilanBasligi: controller.ilanBasligi.text,
                      ilanTipi: controller.ilanTipi.text,
                      ilanNo: controller.ilanNo.text,
                      ilanTarihi: controller.ilanTarihi.text,
                      konutSekli: controller.konutSekli.text,
                      odaSayisi: controller.odaSayisi.text,
                      banyoSayisi: controller.banyoSayisi.text,
                      metreKare: controller.metreKare.text,
                      binaninYasi: controller.binaninYasi.text,
                      kat: controller.kat.text,
                      bulunduguKat: controller.bulunduguKat.text,
                      isinmaTipi: controller.isinmaTipi.text,
                      yakitTipi: controller.yakitTipi.text,
                      yapitipi: controller.yapitipi.text,
                      yapininDurumu: controller.yapininDurumu.text,
                      kullanimDurumu: controller.kullanimDurumu.text,
                      krediyeUygunluk: controller.krediyeUygunluk.text,
                      aidat: controller.aidat.text,
                      takas: controller.takas.text,
                      cepheSecenekleri: controller.cepheSecenekleri.text,
                      kiraGetirisi: controller.kiraGetirisi.text,
                      ilanFiyat: controller.ilanFiyat.text,
                      siteIcerisinde: controller.siteIcerisinde.text,
                      aciklama: controller.aciklama.text,
                    );
                    controller.uploadFiles();
                  },
                  child: Container(
                    height: 50,
                    width: 358,
                    decoration: BoxDecoration(
                        color: Color(0xffD45E39),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      "İlan Ekle",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color(0xffF3F3F3),
                          fontFamily: "Sf Pro"),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<AdvertInfoTextField> adverts = [];

class AdvertInfoTextField extends StatelessWidget {
  const AdvertInfoTextField({
    super.key,
    required this.label,
    required this.type,
    required this.controller,
  });
  final String label;
  final TextInputType type;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 1,
      maxLines: 5,
      keyboardType: type,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xff232455),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xffD45E39),
            )),
        filled: true,
        fillColor: Colors.white,
        label: Text(
          label,
          style: TextStyle(color: Color(0xff232455), fontSize: 15),
        ),
      ),
    );
  }
}
