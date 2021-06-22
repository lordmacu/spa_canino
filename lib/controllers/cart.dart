import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spa_canino/models/Banner.dart';
import 'package:spa_canino/models/Product.dart' as p;


class Cart extends GetxController{



  var baseUrl="http://54.232.24.241";
  var produts= [].obs;


  addCart(user,product) async{

    var url = Uri.parse('${baseUrl}/api/addCart');
    var response = await http.post(url,body: {"user_id":"${user}","product_id":"${product}"});
    }



    deleteItemCart(product) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var json = jsonDecode(prefs.getString("user"));
      var url = Uri.parse('${baseUrl}/api/deleteItemCart');
      var response = await http.post(url,body: {"user_id":"${json["id"]}","product_id":"${product}"});


    }
  getCart() async{
    var popularsLocal=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    produts.value=[];

    print("aquii estoy ");
    if(prefs.getString("user")!=null){
      var json = jsonDecode(prefs.getString("user"));

      var url = Uri.parse('${baseUrl}/api/getCart');
      var response = await http.post(url,body: {"user_id":"${json["id"]}"});

      var jsonData= jsonDecode(response.body);

      print("datass  ${jsonData["data"]}");
      jsonData["data"].forEach((item){

        var productItem= item["product"];


        p.Product product= p.Product();
        product.title= productItem["title"];
        product.description= productItem["description"];
        product.id= productItem["id"];
        product.image= productItem["image"];
        product.quantity= productItem["quantity"];
        product.status= productItem["status"];
        product.price= productItem["price"];
        product.id= productItem["id"];
        popularsLocal.add(product);
      });
      produts.value=popularsLocal;
    }
    update();
  }

  @override
  void onInit() { // called immediately after the widget is allocated memory
    getCart();

    super.onInit();
  }


}