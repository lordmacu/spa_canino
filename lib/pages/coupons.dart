import 'package:flutter/material.dart';

class Coupons extends StatelessWidget {

  List<Color> colors=[Colors.redAccent,Colors.blueAccent,Colors.greenAccent,Colors.pinkAccent,Colors.deepOrangeAccent];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Text(
                "Cupones",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
              margin: EdgeInsets.only(bottom: 10, left: 20),
            )
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Row(
                children: [


                  Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: colors[index],
                          image: DecorationImage(
                            image: AssetImage("assets/coupon.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        height: 170,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(left: 50,right: 50),
                          child:Row(
                            children: [
                              Text("50%",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                              Container(
                                margin: EdgeInsets.only(left: 60),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Spa Completo",style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                    ),


                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text("lavado completo",style: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                      ),


                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                  )
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
