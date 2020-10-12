import 'package:get/get.dart';

class GetStatusControllers extends GetxController{
  RxInt status = 0.obs;
  storeStatus(int value) => status.value = value;
}
