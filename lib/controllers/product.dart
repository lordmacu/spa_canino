// @dart=2.9

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spa_canino/models/Banner.dart';
import 'package:spa_canino/models/Product.dart' as p;


class Product extends GetxController{


  var produts = [].obs;
  var baseUrl="http://54.232.24.241";

  var productIndividual = null.obs;

   Rx<p.Product> productIndi = Rx<p.Product>();



  List chunk(List list, int chunkSize) {
    List chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i+chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }



  getProducts() async{
    var popularsLocal = [].obs;

    var url = Uri.parse('${baseUrl}/api/products');
    var response = await http.get(url);
    var json= jsonDecode(response.body);

    json["data"].forEach((item){

      var productItem= item;


      p.Product product= p.Product();
      product.title= productItem["title"];
      product.description= productItem["description"];
      product.id= productItem["id"];
      product.image= productItem["image"];
      product.quantity= productItem["quantity"];
      product.status= productItem["status"];
      product.category=productItem["category"]["name"];
      product.price= productItem["price"];




      popularsLocal.add(product);
    });

    produts.value=chunk(popularsLocal, 2);

    print("aquii produts ${produts}");
  }

  @override
  void onInit() { // called immediately after the widget is allocated memory


    getProducts();



    super.onInit();
  }


}