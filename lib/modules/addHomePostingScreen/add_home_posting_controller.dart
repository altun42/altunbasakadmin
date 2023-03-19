import 'dart:io';

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

  void pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage();

    if (pickedImages != null) {
      pickedImages.forEach((pickedImage) {
        addPhoto(pickedImage.path);
      });
    }
  }

  void removeImage(int index) {
    photoss.removeAt(index);
  }
}
