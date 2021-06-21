import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spa_canino/models/Banner.dart';
import 'package:spa_canino/models/Product.dart' as p;


class UserLogin extends GetxController{


  var isLogged=false.obs;




  @override
  void onInit() { // called immediately after the widget is allocated memory

    super.onInit();
  }


}