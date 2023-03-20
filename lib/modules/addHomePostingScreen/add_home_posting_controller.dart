import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddHomePostingController extends GetxController {
  GoogleMapController? mapController;
  RxString currentAddress = "".obs;
  Rx<LatLng?> selectedLocation = Rx<LatLng?>(null);
  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> onMapTap(LatLng latLng) async {
    try {
      selectedLocation.value = latLng;
      getAddressFromLatLng(latLng);
      updateAddress();
    } catch (e) {
      Get.snackbar("title", "message");
      updateAddress();
    }
  }

  void updateAddress() async {
    if (selectedLocation.value == null) return;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedLocation.value!.latitude, selectedLocation.value!.longitude);
  }

  Future<void> moveToAdress(String adress) async {
    List<Location> locations = await locationFromAddress(adress);
    if (locations.length > 0) {
      LatLng latLng =
          LatLng(locations.first.latitude, locations.first.longitude);
      selectedLocation.value = latLng;
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 15);
      mapController?.animateCamera(cameraUpdate);
      currentAddress.value = adress;
      update();
    } else {
      Get.snackbar("Hata", "Adres Bulunamadı");
    }
  }

  Future<void> getAddressFromLatLng(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        addressController.value.text =
            "${place.street},${place.postalCode},${place.country},${place.administrativeArea}/${place.subAdministrativeArea}";
      }
    } catch (e) {
      print(e);
    }
  }

  Rx<TextEditingController> addressController = TextEditingController().obs;

  RxList<File> images = RxList<File>([]);
  final photoss = [].obs;
  List get photos => photoss.value;
  void addPhoto(String path) {
    photoss.add(path);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    photoss.clear();
  }

  @override
  void onReady() {
    super.onReady();
  }

  TextEditingController ilanNo = TextEditingController();
  TextEditingController ilanTarihi = TextEditingController();
  TextEditingController ilanBasligi = TextEditingController();
  TextEditingController ilanTipi = TextEditingController();
  TextEditingController ilanFiyat = TextEditingController();

  TextEditingController konutSekli = TextEditingController();

  TextEditingController odaSayisi = TextEditingController();

  TextEditingController banyoSayisi = TextEditingController();

  TextEditingController metreKare = TextEditingController();

  TextEditingController binaninYasi = TextEditingController();

  TextEditingController kat = TextEditingController();
  TextEditingController bulunduguKat = TextEditingController();

  TextEditingController isinmaTipi = TextEditingController();

  TextEditingController yakitTipi = TextEditingController();

  TextEditingController yapitipi = TextEditingController();

  TextEditingController yapininDurumu = TextEditingController();

  TextEditingController kullanimDurumu = TextEditingController();

  TextEditingController krediyeUygunluk = TextEditingController();

  TextEditingController aidat = TextEditingController();
  TextEditingController takas = TextEditingController();

  TextEditingController cepheSecenekleri = TextEditingController();

  TextEditingController kiraGetirisi = TextEditingController();
  TextEditingController siteIcerisinde = TextEditingController();
  TextEditingController aciklama = TextEditingController();
  List<XFile>? pickedImages;
  void pickImages() async {
    final picker = ImagePicker();
    pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      pickedImages!.forEach((pickedImage) {
        addPhoto(pickedImage.path);
      });
    }
  }

  void removeImage(int index) {
    photoss.removeAt(index);
  }

  Future<void> uploadFiles() async {
    for (var xfile in pickedImages!) {
      var fileName = xfile.path.split("/").last;
      var filePath = "${ilanNo.text}/$fileName";

      var file = File(xfile.path);
      var ref = FirebaseStorage.instance.ref().child(filePath);
      await ref.putFile(file).then((TaskSnapshot taskSnapshot) async {
        if (taskSnapshot.state == TaskState.success) {
          var downloadUrl = await ref.getDownloadURL();
          Get.snackbar("Başarılı", "Fotoğraflar Eklendi");
        } else {
          Get.snackbar("title", "message");
        }
      });
    }
  }

  Future createHomeAd(
      {required String ilanBasligi,
      required String ilanTipi,
      required String ilanNo,
      required String ilanTarihi,
      required String konutSekli,
      required String odaSayisi,
      required String banyoSayisi,
      required String metreKare,
      required String binaninYasi,
      required String kat,
      required String bulunduguKat,
      required String isinmaTipi,
      required String yakitTipi,
      required String yapitipi,
      required String yapininDurumu,
      required String kullanimDurumu,
      required String krediyeUygunluk,
      required String aidat,
      required String takas,
      required String cepheSecenekleri,
      required String kiraGetirisi,
      required String ilanFiyat,
      required String siteIcerisinde,
      required String aciklama}) async {
    if (ilanBasligi.isNotEmpty && ilanNo.isNotEmpty) {
      DocumentReference docAd =
          FirebaseFirestore.instance.collection("homeAds").doc(ilanNo);
      final json = {
        "ilanBasligi": ilanBasligi,
        "ilanTipi": ilanTipi.isNotEmpty ? ilanTipi : "Belirtilmedi",
        "ilanNo": ilanNo,
        "ilanTarihi": ilanTarihi.isNotEmpty ? ilanTarihi : "Belirtilmedi",
        "konutSekli": konutSekli.isNotEmpty ? konutSekli : "Belirtilmedi",
        "odaSayisi": odaSayisi.isNotEmpty ? odaSayisi : "Belirtilmedi",
        "banyoSayisi": banyoSayisi.isNotEmpty ? banyoSayisi : "Belirtilmedi",
        "metreKare": metreKare.isNotEmpty ? metreKare : "Belirtilmedi",
        "binaninYasi": binaninYasi.isNotEmpty ? binaninYasi : "Belirtilmedi",
        "binadakiKatSayisi": kat.isNotEmpty ? kat : "Belirtilmedi",
        "bulunduguKat": bulunduguKat.isNotEmpty ? bulunduguKat : "Belirtilmedi",
        "isinmaTipi": isinmaTipi.isNotEmpty ? isinmaTipi : "Belirtilmedi",
        "yakitTipi": yakitTipi.isNotEmpty ? yakitTipi : "Belirtilmedi",
        "yapiTipi": yapitipi.isNotEmpty ? yapitipi : "Belirtilmedi",
        "yapininDurumu":
            yapininDurumu.isNotEmpty ? yapininDurumu : "Belirtilmedi",
        "kullanimDurumu":
            kullanimDurumu.isNotEmpty ? kullanimDurumu : "Belirtilmedi",
        "krediyeUygunluk":
            krediyeUygunluk.isNotEmpty ? krediyeUygunluk : "Belirtilmedi",
        "aidat": aidat.isNotEmpty ? aidat : "Belirtilmedi",
        "takas": takas.isNotEmpty ? takas : "Belirtilmedi",
        "cepheSecenekleri":
            cepheSecenekleri.isNotEmpty ? cepheSecenekleri : "Belirtilmedi",
        "kiraGetirisi": kiraGetirisi.isNotEmpty ? kiraGetirisi : "Belirtilmedi",
        "fiyat": ilanFiyat.isNotEmpty ? ilanFiyat : "Belirtilmedi",
        "siteIcerisinde":
            siteIcerisinde.isNotEmpty ? siteIcerisinde : "Belirtilmedi",
        "aciklama": aciklama.isNotEmpty ? aciklama : "Belirtilmedi"
      };
      await docAd.set(json);
      Get.snackbar("Başarılı", "İlan Eklendi",
          titleText: Text(
            "Başarılı",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Sf Pro",
              color: Color(0xffD45E39),
            ),
          ),
          messageText: Text(
            "İlan Eklendi",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Sf Pro",
              color: Color(0xff232455),
            ),
          ),
          backgroundColor: Colors.white);
    } else {
      Get.snackbar("Başarısız", "Lütfen Zorunlu Alanları Doldurunuz",
          titleText: Text(
            "Başarısız",
            style: TextStyle(
              fontSize: 20,
              fontFamily: "Sf Pro",
              color: Color(0xffD45E39),
            ),
          ),
          messageText: Text(
            "Lütfen Zorunlu Alanları Doldurunuz",
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Sf Pro",
              color: Color(0xff232455),
            ),
          ),
          backgroundColor: Colors.white);
    }
  }
}
