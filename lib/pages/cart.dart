import 'package:flutter/material.dart';
import 'package:spa_canino/controllers/cart.dart';
import 'package:spa_canino/pages/ui/itemCard.dart';
import 'package:spa_canino/controllers/product.dart';
import 'package:get/get.dart';
import 'package:spa_canino/helper.dart' as helper;
import 'package:spa_canino/controllers/cart.dart' as c;

class Cart extends StatelessWidget {
  final c.Cart cart = Get.put(c.Cart());
  Function goBack;

  Cart({this.goBack});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height - 90;

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  goBack();
                },
                child: Container(
                  color: Colors.white,
                  child:Icon(Icons.arrow_back_ios) ,
                ),
              ),
              Container(
                child: Text(
                  "Carro de productos",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                margin: EdgeInsets.only(bottom: 10, left: 10, top: 20),
              )
            ],
          ),
          Expanded(child: GetBuilder<c.Cart>(
            builder: (_dx) => ListView.builder(
              itemCount: _dx.produts.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Image.network(
                            helper.Helper.getImage(_dx.produts[index].image)),
                        width: 100,
                        margin: EdgeInsets.only(right: 10),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(

                            children: [
                              Container(

                                child: Text(
                                  "${_dx.produts[index].title}",
                                  style: TextStyle(
                                      fontSize: 17, fontWeight: FontWeight.bold),
                                ),
                                margin: EdgeInsets.only(bottom: 5),
                              ),
                              Text(
                                "\$${_dx.produts[index].price}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w400),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        flex: 3,
                      ),
                      Expanded(
                        child: InkWell(

                          child: Container(


                            child: Icon(Icons.close,color: Colors.grey.withOpacity(0.7),),
                             padding: EdgeInsets.only(top: 5,bottom: 5),

                          ),
                          onTap: () async{

                            await cart.deleteItemCart(_dx.produts[index].id);
                            await cart.getCart();

                          },

                        ),
                        flex: 1,
                      )
                    ],
                  ),
                );
              },
            ),
          )),

        ],
      ),
    );
  }
}
