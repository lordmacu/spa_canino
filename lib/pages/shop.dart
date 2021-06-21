import 'package:flutter/material.dart';
import 'package:spa_canino/controllers/home.dart';
import 'package:spa_canino/pages/ui/itemCard.dart';
import 'package:spa_canino/controllers/product.dart';
import 'package:get/get.dart';
import 'package:spa_canino/helper.dart' as helper;


class Shop extends StatelessWidget{

  Function ShowProduct;

  Shop({this.ShowProduct});

  final Product product = Get.put(Product());
  final Home home = Get.put(Home());

  getProducts(){
    List<Widget> rowPopular=[];


    product.produts.forEach((item){

      rowPopular.add(Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            item.length>0 ? Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: (){
                    home.showPanel.value = 5;
                    product.productIndi.value = item[1];
                  },
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
                          child: Image. network(helper.Helper.getImage(item[0].image) ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "${item[0].title}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "\$${item[0].price}",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )):Container(),
            item.length>1 ? Expanded(
                flex: 5,
                child: GestureDetector(
                  onTap: (){

                  },
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
                          child: Image.network(helper.Helper.getImage(item[1].image)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "${item[1].title}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Text(
                            "\$${item[0].price}",
                            style: TextStyle(
                                color: Colors.grey, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                )):Container(),
          ],
        ),
      ));
    });

    return rowPopular;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height-90;

    return    Container(

     padding: EdgeInsets.only(left: 20, right: 20),
      child:Column(
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
         Expanded(
           child: Column(
             children: getProducts(),
           ),
         )
       ],
     ),
   );
  }

}