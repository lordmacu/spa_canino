import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spa_canino/controllers/cart.dart';
import 'package:spa_canino/controllers/userLogin.dart';
import 'package:spa_canino/pages/ui/itemCard.dart';
import 'package:spa_canino/controllers/product.dart';
import 'package:get/get.dart';
import 'package:spa_canino/helper.dart' as helper;
import 'package:spa_canino/models/Product.dart' as p;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:spa_canino/pages/ui/modalUser.dart';

class ProductPage extends StatelessWidget {
  final Cart cart = Get.put(Cart());
  final UserLogin userLogin = Get.put(UserLogin());

  Function closeCart;
  ProductPage({this.closeCart});

  final Product product = Get.find();
  BuildContext dialogContext; // <<----

  showLogin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString("user")==null){
      dialogContext=context;
    Alert(
        context: context,

        title: "",
        style: AlertStyle(
            alertPadding: EdgeInsets.only(top: 0),
            titleStyle: TextStyle(height: 0)),
        content: Modaluser(
          OnLoginCall: (int status) async {
            if (status == 200) {

              print("aquii status200");

              SharedPreferences prefs = await SharedPreferences.getInstance();
              var json = jsonDecode(prefs.getString("user"));
              print("aquii usereeeee  ${json}");

              cart.addCart(json["id"], product.productIndi.value.id);
            }
            Navigator.pop(dialogContext);
            closeCart();


          },
        ),
        buttons: []).show();
    }else{
      var json = jsonDecode(prefs.getString("user"));
      cart.addCart(json["id"], product.productIndi.value.id);
      closeCart();


    }

  }

  @override
  Widget build(BuildContext context) {
    print("asuii esta el producto ${product}");
    // TODO: implement build
    double height = MediaQuery.of(context).size.height - 90;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: RaisedButton(
          color: Color(0xffe5454c),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
          ),
          onPressed: () {
            showLogin(context);
            //cart.addCart();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_shopping_cart_outlined,
                color: Colors.white,
              ),
              Text(
                "Agregar al carrito",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Container(

        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                        child: Obx(() => Image.network(
                          helper.Helper.getImage(product.productIndi.value.image),
                          fit: BoxFit.cover,
                        )),
                        margin: EdgeInsets.only(bottom: 20, left: 10),
                      ))
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Container(

                        child: Obx(() => Text(
                          "${product.productIndi.value.title}",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 25),
                        )),
                        margin: EdgeInsets.only(bottom: 10, left: 10,top: 20),
                      )),
                      Expanded(child: Container(

                        child: Obx(() => Text(
                          "\$${product.productIndi.value.price}",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 30),
                        )),
                        margin: EdgeInsets.only(bottom: 10, left: 10,top: 20),
                      ))
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(child: Container(

                    child: Obx(() => Text(
                      "${product.productIndi.value.description}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    )),
                    margin: EdgeInsets.only(bottom: 10, left: 10,top: 20),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
