import 'package:altunbasakadmin/shared/constants/data_model.dart';
import 'package:altunbasakadmin/shared/constants/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomescreenController extends GetxController {
  var dataList = <Data>[].obs;
  FirestoreService firestoreService = FirestoreService();

  Future<void> initData() async {
    final stream = await firestoreService.getStreamData();
    stream.listen((event) {
      dataList.assignAll(event);
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
}
