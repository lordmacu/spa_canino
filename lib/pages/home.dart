import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import 'package:spa_canino/controllers/home.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:spa_canino/pages/about.dart';
import 'package:spa_canino/pages/contact.dart';
import 'package:spa_canino/pages/coupons.dart';
import 'package:spa_canino/pages/menu.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spa_canino/pages/shop.dart';

class HomePage extends StatelessWidget {
  final Home home = Get.put(Home());
  PanelController controler= PanelController();

  List<String> images = [];

  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();



  Widget showScreen(){
    if(home.showPanel.value==1){
      return Expanded(child:  Shop());
    }else if(home.showPanel.value==1){
      return Expanded(child:  Coupons());
    }else if(home.showPanel.value==3){
      return Expanded(child:  About());
    }else if(home.showPanel.value==4){
      return Expanded(child:  Contact());
    }

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: true,
        swipe: true,
        colorTransitionChild: Color(0xff41A099),
        colorTransitionScaffold: Color(0xff41A099).withOpacity(0.1),
        proportionalChildArea: true,
        borderRadius: 10,
        backgroundDecoration: BoxDecoration(color: Color(0xff41A099)),
        onDragUpdate: (distance, direction) {
          if (distance < 0.01) {
            if (!home.isOpenMenu.value) {
              print("distance ${distance}  ${direction}  ${home.showPanel.value}");
              if(home.showPanel.value!=4){
                controler.open();

              }
            }
          }
        },
        leftChild: Menu(
          onback: () {
            _innerDrawerKey.currentState.close();
            home.closeMenu();
          },
          onSelectItem: (item) async {
            _innerDrawerKey.currentState.close();
            if(item=="about"){
              home.setPanel(3);
            }
            if(item=="contact"){
              home.setPanel(4);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contact()),
              );
            }
            print("este es el item  ${item}");
            home.closeMenu();
          },
        ),
        scaffold: Scaffold(
          body: SlidingUpPanel(
            backdropEnabled: true,
            minHeight: 0,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft:  Radius.circular(10)),
            maxHeight: height-30,
            controller: controler,

            panel: Container(
              child: Column(
                children: [
                  Container(
                    child: Icon(Icons.drag_handle,color: Colors.grey,),
                  ),
              Obx(() =>showScreen())

                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    margin: EdgeInsets.only(top: 35, left: 15, right: 15),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            print("aqui esta haciendo la cosa");
                            _innerDrawerKey.currentState.open();
                            home.openMenu();
                          },
                          child: Icon(
                            Icons.menu,
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                            child: TextFormField(
                              maxLines: 1,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 15),
                                hintText: 'Encuentra el producto para tu mascota..',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            )),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    height: 200,
                    child: Obx(() => Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(home.banners[index]);
                      },
                      itemCount: home.banners.length,
                      viewportFraction: 0.9,
                      scale: 1,
                    )),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                              onTap: (){
                                home.setPanel(1);
                                controler.open();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15, right: 10),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.shopping_basket_outlined,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Tienda",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xffe5454c),
                                ),
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                              ),
                            )),
                        Expanded(
                            child: GestureDetector(
                              onTap: (){
                                home.setPanel(2);
                                controler.open();
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15, right: 10),
                                child: Column(
                                  children: [
                                    Icon(Icons.add_shopping_cart_outlined,
                                        size: 50, color: Colors.white),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Cupones",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Color(0xff5653d4),
                                ),
                                padding: EdgeInsets.only(top: 15, bottom: 15),
                              ),
                            )),
                        Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 15, right: 10),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.medical_services_outlined,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Clínica",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                ],
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Color(0xff08a791),
                              ),
                              padding: EdgeInsets.only(top: 15, bottom: 15),
                            )),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10, top: 40),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Text(
                                "Productos",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              margin: EdgeInsets.only(bottom: 10, left: 10),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Image.asset("assets/banner1.png"),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "Producto 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Esta es una descripcion del producto",
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Image.asset("assets/banner1.png"),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "Producto 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Esta es una descripcion del producto",
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Image.asset("assets/banner1.png"),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "Producto 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Esta es una descripcion del producto",
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)),
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Image.asset("assets/banner1.png"),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: Text(
                                            "Producto 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Esta es una descripcion del producto",
                                            style: TextStyle(
                                                color: Colors.grey, fontSize: 13),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
