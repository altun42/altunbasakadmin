import 'package:altunbasakadmin/modules/addHomePostingScreen/add_home_posting_binding.dart';
import 'package:altunbasakadmin/modules/addHomePostingScreen/add_home_posting_screen.dart';
import 'package:altunbasakadmin/modules/homeScreen/home_screen.dart';
import 'package:altunbasakadmin/modules/homeScreen/home_screen_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
        name: Routes.HOME,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding()),
    GetPage(
        name: Routes.ADDHOMEPOSTING,
        page: () => AddHomePostingScreen(),
        binding: AddHomePostingBinding())
  ];
}
