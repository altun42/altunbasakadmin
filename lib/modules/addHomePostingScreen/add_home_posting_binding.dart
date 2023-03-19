import 'package:altunbasakadmin/modules/addHomePostingScreen/add_home_posting_controller.dart';
import 'package:get/get.dart';

class AddHomePostingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddHomePostingController>(() => AddHomePostingController());
  }

}