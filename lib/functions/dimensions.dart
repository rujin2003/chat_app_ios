// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class Dimensions {
  static double screenheight = Get.context!.height;
  static double screenwidth = Get.context!.width;

  static double home_bodyPage_maincontainer = screenheight / 2.64;
  static double home_bodyPage_img = screenheight / 3.85;
  static double home_bodyPage_lable = screenheight / 7.30;

  static Static_margins_and_paddings(double screenheight, double x) {
    var margins_and_paddins = screenheight / (899 / x);
    return margins_and_paddins;
  }
}
