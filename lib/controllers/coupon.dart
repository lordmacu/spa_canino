// @dart=2.9

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spa_canino/models/Banner.dart';
 import 'package:spa_canino/models/Coupon.dart' as c;
import 'package:shared_preferences/shared_preferences.dart';

class Coupon extends GetxController{


  var coupons = [].obs;
  var mycoupons = [].obs;
  var baseUrl="http://54.232.24.241";

  var tab=0.obs;


  // Rx<p.Product> productIndi = Rx<p.Product>();

  var productIndi = c.Coupon().obs;



  postCupon(couponId) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString("user")!=null){
      var jsonUser = jsonDecode(prefs.getString("user"));

      var url = Uri.parse('${baseUrl}/api/postCoupon');

      var response = await http.post(url,body: {"user":"${jsonUser["id"]}","coupon":"${couponId}"});
      var json= jsonDecode(response.body);

      print("post coupon user  ${json}");

    }

    getCouponsUser();


  }

  getCouponsUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var couoponsLocal = [].obs;

    var couponsIds=[];

    if(prefs.getString("user")!=null){
      var jsonUser = jsonDecode(prefs.getString("user"));

      var url = Uri.parse('${baseUrl}/api/getCouponUser');

      var response = await http.post(url,body: {"user":"${jsonUser["id"]}"});
      var json= jsonDecode(response.body);

      json["data"].forEach((item){
        var productItem= item["coupon"];
        c.Coupon product= c.Coupon();
        product.name= productItem["name"];
        product.price= productItem["price"];
        product.code= productItem["code"];
        product.date= productItem["date"];
        product.description= productItem["description"];
        product.id= productItem["id"];
        product.color= productItem["color"];
        couponsIds.add(product.id);
        couoponsLocal.add(product);
      });

      mycoupons=couoponsLocal;


    }
    getCopons(couponsIds);
    update();


  }

  getCouponUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var couoponsLocal = [].obs;
    var couponsIds=[];

    if(prefs.getString("user")!=null){
      var jsonUser = jsonDecode(prefs.getString("user"));

      var url = Uri.parse('${baseUrl}/api/getCouponUser');

      var response = await http.post(url,body: {"user":"${jsonUser["id"]}"});
      var json= jsonDecode(response.body);

      print("get coupon user  ${json}");

      json["data"].forEach((item){
        var productItem= item["coupon"];
        c.Coupon product= c.Coupon();
        product.name= productItem["name"];
        product.price= productItem["price"];
        product.code= productItem["code"];
        product.date= productItem["date"];
        product.description= productItem["description"];
        product.id= productItem["id"];
        product.color= productItem["color"];
        couoponsLocal.add(product);
        couponsIds.add(product.id);

      });

      mycoupons=couoponsLocal;

      print("aqui mis coupones  ${mycoupons}");

    }

    getCopons(couponsIds);


  }

  getCopons(List ids) async{
    var couoponsLocal = [].obs;

    var url = Uri.parse('${baseUrl}/api/coupons');

    var response = await http.get(url);
    var json= jsonDecode(response.body);

    json["data"].forEach((item){
      var productItem= item;
      c.Coupon product= c.Coupon();
      product.name= productItem["name"];
      product.price= productItem["price"];
      product.code= productItem["code"];
      product.date= productItem["date"];
      product.description= productItem["description"];
      product.id= productItem["id"];
      product.color= productItem["color"];

      if(ids.contains(productItem["id"])){
        product.isUsed= true;
      }else{
        product.isUsed= false;


        couoponsLocal.add(product);

      }


    });
    coupons=couoponsLocal;
    update();
  }

  @override
  void onInit() {


    super.onInit();
  }


}