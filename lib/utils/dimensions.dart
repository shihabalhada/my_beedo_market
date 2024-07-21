import 'package:get/get.dart';
class Dimensions{
  static double screenHeight=Get.context!.height;
  static double screenWidth=Get.context!.width;


  static double getHeight(double height){
    return screenHeight/(797.71/height);
  }
  static double getWidth(double width){
    return screenWidth/(411.42/width);
  }
}