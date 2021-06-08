import 'package:flutter/material.dart';

class Menu extends StatelessWidget{

  Function onback;
  Function onSelectItem;
  Menu({this.onback,this.onSelectItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff41A099),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 30,left: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        margin: EdgeInsets.only(bottom: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child:ClipOval(

                          child: Image.asset("assets/avatar.png"),
                        ) ,
                      ),
                      Text("Registrarme",style: TextStyle(color: Colors.white,fontSize: 15),)
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     InkWell(
                       onTap: (){
                         onSelectItem("store");
                       },
                       child:  Container(
                         padding: EdgeInsets.only(bottom: 15,top: 15,left: 30),

                         child: Row(
                           children: [
                             Container(

                               child: Icon(Icons.shopping_basket_outlined,color: Colors.white,size: 30,),
                               margin: EdgeInsets.only(right: 10),
                             ),
                             Text("Tienda",style: TextStyle(color: Colors.white,fontSize: 17),)
                           ],
                         ),
                       ),
                     ),

                      InkWell(
                        onTap: (){
                          onSelectItem("appointment");
                        },
                        child:  Container(
                          padding: EdgeInsets.only(bottom: 15,top: 15,left: 30),

                          child: Row(
                            children: [
                              Container(

                                child: Icon(Icons.calendar_today_outlined,color: Colors.white,size: 30,),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Text("Citas",style: TextStyle(color: Colors.white,fontSize: 17),)
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          onSelectItem("doctos");

                        },
                        child:  Container(
                          padding: EdgeInsets.only(bottom: 15,top: 15,left: 30),

                          child: Row(
                            children: [
                              Container(

                                child: Icon(Icons.healing,color: Colors.white,size: 30,),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Text("Nuestros doctores",style: TextStyle(color: Colors.white,fontSize: 17),)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          onSelectItem("contact");

                        },
                        child:  Container(
                          padding: EdgeInsets.only(bottom: 15,top: 15,left: 30),

                          child: Row(
                            children: [
                              Container(

                                child: Icon(Icons.mail_outline,color: Colors.white,size: 30,),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Text("Contáctenos",style: TextStyle(color: Colors.white,fontSize: 17),)
                            ],
                          ),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          onSelectItem("about");

                        },
                        child:  Container(
                          padding: EdgeInsets.only(bottom: 15,top: 15,left: 30),

                          child: Row(
                            children: [
                              Container(

                                child: Icon(Icons.info_outline,color: Colors.white,size: 30,),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Text("About",style: TextStyle(color: Colors.white,fontSize: 17),)
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 50,
              right: 20,
              child: InkWell(
                onTap: (){

                  onback();
                },
                child: Container(
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                ),
              )
          )

        ],
      ),
    );
  }

}