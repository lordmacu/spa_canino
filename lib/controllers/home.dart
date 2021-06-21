import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spa_canino/models/Banner.dart';
import 'package:spa_canino/models/Product.dart';


class Home extends GetxController{

  var banners = [].obs;
  var produts = [].obs;
  var populars = [].obs;
  var isOpenMenu = false.obs;
  var showPanel = 1.obs;
  var baseUrl="http://54.232.24.241";


  void closeMenu(){
    this.isOpenMenu.value=false;
  }


  void setPanel(number){
   this.showPanel.value=number;
  }
  void openMenu(){
    this.isOpenMenu.value=true;
  }

  getBanners() async{

    var url = Uri.parse('${baseUrl}/api/banners');
    var response = await http.get(url);
    var json= jsonDecode(response.body);

    json["data"].forEach((item){
         banners.add(Banner(item["url"], item["image"]));
    });

  }

  List chunk(List list, int chunkSize) {
    List chunks = [];
    int len = list.length;
    for (var i = 0; i < len; i += chunkSize) {
      int size = i+chunkSize;
      chunks.add(list.sublist(i, size > len ? len : size));
    }
    return chunks;
  }


  getPopulars() async{
    var popularsLocal = [].obs;

    var url = Uri.parse('${baseUrl}/api/populars');
    var response = await http.get(url);
    var json= jsonDecode(response.body);

    json["data"].forEach((item){
      var productItem= item["product"];
      Product product= Product();
      product.title= productItem["title"];
      product.description= productItem["description"];
      product.id= productItem["id"];
      product.image= productItem["image"];
      product.quantity= productItem["quantity"];
      product.price= productItem["price"];
      product.status= productItem["status"];

      product.category=productItem["category"]["name"];

      popularsLocal.add(product);
    });

    populars.value=chunk(popularsLocal, 2);

    print("aquii popular ${populars}");
  }


  getProducts() async{
    var popularsLocal = [].obs;

    var url = Uri.parse('${baseUrl}/api/populars');
    var response = await http.get(url);
    var json= jsonDecode(response.body);

    json["data"].forEach((item){
      var productItem= item;

      Product product= Product();
      product.title= productItem["title"];
      product.description= productItem["description"];
      product.id= productItem["id"];
      product.image= productItem["image"];
      product.quantity= productItem["quantity"];
      product.status= productItem["title"];
      product.category= productItem["title"];
      product.status=productItem["category"]["name"];

      popularsLocal.add(product);
    });

    produts.value=chunk(popularsLocal, 2);

    print("aquii produts ${produts}");
  }

  @override
  void onInit() { // called immediately after the widget is allocated memory

    getBanners();
    getPopulars();



    super.onInit();
  }


}