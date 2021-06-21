import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spa_canino/models/Banner.dart';
import 'package:spa_canino/models/Product.dart' as p;


class UserLogin extends GetxController{


  var isLogged=false.obs;
  var baseUrl="http://54.232.24.241";


  register(email,name,password) async{
    var url = Uri.parse('${baseUrl}/api/register');
    var response = await http.post(url,body:{"email":email,"name":name,"password":password});
    var json= jsonDecode(response.body);
    return json;
  }

  login(email,password) async{
    var url = Uri.parse('${baseUrl}/api/login');
    var response = await http.post(url,body:{"email":email,"password":password});
    var json= jsonDecode(response.body);
    return json;
  }


  @override
  void onInit() { // called immediately after the widget is allocated memory

    super.onInit();
  }


}