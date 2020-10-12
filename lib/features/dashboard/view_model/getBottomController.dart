import 'package:get/get.dart';

class GetStatusControllers extends GetxController{
  RxInt id = 0.obs;
  RxBool list = false.obs;
  storeStatus(int value,bool status) {
    id.value = value;
    list.value = status;
  }
}