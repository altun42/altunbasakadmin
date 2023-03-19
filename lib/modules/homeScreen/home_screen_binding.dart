import 'package:altunbasakadmin/modules/homeScreen/home_screen_controller.dart';
import 'package:get/get.dart';

class HomeScreenBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomescreenController>(() => HomescreenController());
  }

}