import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spa_canino/controllers/coupon.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:spa_canino/pages/ui/modalUser.dart';

class Coupons extends StatelessWidget {
  List<Color> colors = [
    Colors.redAccent,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.deepOrangeAccent
  ];
  final Coupon coupons = Get.put(Coupon());
  BuildContext dialogContext; // <<----

  showLogin(context,coupon) async {
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
                coupons.postCupon(coupon);

              }
              Navigator.pop(dialogContext);



            },
          ),
          buttons: []).show();
    }else{

      coupons.postCupon(coupon);

    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    color: coupons.tab.value == 0
                        ? Color(0xffe5454c)
                        : Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      coupons.tab.value = 0;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cupones disponibles",
                          style: TextStyle(
                              color: coupons.tab.value == 1
                                  ? Color(0xffe5454c)
                                  : Colors.white),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    color: coupons.tab.value == 1
                        ? Color(0xffe5454c)
                        : Colors.white,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      coupons.tab.value = 1;
                      coupons.getCouponUser();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Mis cupones",
                          style: TextStyle(
                              color: coupons.tab.value == 1
                                  ? Colors.white
                                  : Color(0xffe5454c)),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
        Obx(() => Container(
              child: coupons.tab == 0
                  ? Row(
                      children: [
                        Container(
                          child: Obx(() => Text(
                                "${coupons.coupons.length} cupones disponibles",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )),
                          margin: EdgeInsets.only(bottom: 10, left: 20),
                        )
                      ],
                    )
                  : Row(
                      children: [
                        Container(
                          child:Text(
                            "Cupones utilizados",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          margin: EdgeInsets.only(bottom: 10, left: 20),
                        )
                      ],
                    ),
            )),
        Visibility(
          child: Text("${coupons.coupons.length}"),
          visible: false,
        ),
        Obx(() => Container(
              child: coupons.tab == 0
                  ? GetBuilder<Coupon>(
                      builder: (_dx) => _dx.coupons.length > 0
                          ? Expanded(
                              child: ListView.builder(
                              itemCount: _dx.coupons.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    if(! _dx.coupons[index].isUsed ){
                                      showLogin(context,_dx.coupons[index].id);

                                    }else{
                                      Toast.show("Cupón previamente utilizado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.orangeAccent,textColor: Colors.black);

                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                          color: _dx.coupons[index].isUsed ?  Color(int.parse(
                                              "0xff${_dx.coupons[index].color}"
                                                  .replaceAll("#", ""))).withOpacity(0.5) : Color(int.parse(
                                              "0xff${_dx.coupons[index].color}"
                                                  .replaceAll("#", ""))),
                                          image: DecorationImage(
                                            image:
                                                AssetImage("assets/coupon.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        height: 170,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.only(
                                              left: 50, right: 50),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${_dx.coupons[index].price}%",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 60),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "${_dx.coupons[index].name}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "${_dx.coupons[index].description}",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      width: 120,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "${_dx.coupons[index].code}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      width: 120,
                                                    ),

                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              },
                            ))
                          : Expanded(
                              child: Container(
                              child: Center(
                                child: Text("No hay cupones dispoinibles"),
                              ),
                            )),
                    )
                  : GetBuilder<Coupon>(
                      builder: (_dx) => _dx.mycoupons.length > 0
                          ? Expanded(
                              child: ListView.builder(
                              itemCount: _dx.mycoupons.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Toast.show("Cupón previamente utilizado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.orangeAccent,textColor: Colors.black);

                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        decoration: BoxDecoration(
                                          color: Color(int.parse(
                                              "0xff${_dx.mycoupons[index].color}"
                                                  .replaceAll("#", ""))).withOpacity(0.5),
                                          image: DecorationImage(
                                            image:
                                                AssetImage("assets/coupon.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        height: 170,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          padding: EdgeInsets.only(
                                              left: 50, right: 50),
                                          child: Row(
                                            children: [
                                              Text(
                                                "${_dx.mycoupons[index].price}%",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 60),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "${_dx.mycoupons[index].name}",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 22,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "${_dx.mycoupons[index].description}",
                                                        style: TextStyle(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      width: 120,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
                                                      child: Text(
                                                        "${_dx.mycoupons[index].code}",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      width: 120,
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              },
                            ))
                          : Expanded(
                              child: Container(
                              child: Center(
                                child: Text("No tienes cupones dispoinibles"),
                              ),
                            )),
                    ),
            ))
      ],
    );
  }
}
