import 'dart:ffi';

import 'package:altunbasakadmin/shared/constants/data_model.dart';
import 'package:altunbasakadmin/shared/constants/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class HomescreenController extends GetxController {
  var dataList = <Data>[].obs;
  var items = [].obs;
  FirestoreService firestoreService = FirestoreService();

  Future<void> initData() async {
    final stream = await firestoreService.getStreamData();
    stream.listen((event) {
      dataList.assignAll(event);
      getPhotos(dataList[dataList.length - 1].ilanNo);

      update();
    });
  }

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() {
    initData();
    super.onReady();
  }

  Future<void> downloadURL(String imageName) async {
    FirebaseStorage.instance.ref(imageName);
  }

  Future<void> getPhotos(String path) async {
    final storageRef = FirebaseStorage.instance.ref(path);
    final listResult = await storageRef.listAll();
    for (var item in listResult.items) {
      String url =
          await FirebaseStorage.instance.ref(item.fullPath).getDownloadURL();
      items.add(url);
    }
  }
}
