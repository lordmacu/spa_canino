import 'package:flutter/material.dart';

class About extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              child: Text("Sobre nosotros",style: TextStyle(fontSize: 20),),
              margin: EdgeInsets.only(bottom: 20,top: 10),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              margin: EdgeInsets.only(bottom: 10),
              child: Text("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",style: TextStyle(fontSize: 17),),
            ),
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              margin: EdgeInsets.only(bottom: 10),
              child: Text("There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.",style: TextStyle(fontSize: 17),),
            ),
          ],
        ),
      ),
    );
  }
}
