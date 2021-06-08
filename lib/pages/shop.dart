import 'package:flutter/material.dart';
import 'package:spa_canino/pages/ui/itemCard.dart';


class Shop extends StatelessWidget{
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
           child: ListView.builder(
             itemCount: 10,
             itemBuilder: (context, index) {
               return Row(
                 children: [
                   ItemCard(),
                   ItemCard()
                 ],
               );
             },
           ),
         )
       ],
     ),
   );
  }

}