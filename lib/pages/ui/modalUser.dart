
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spa_canino/controllers/userLogin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Modaluser extends StatefulWidget {
   final Function(int) OnLoginCall;

  Modaluser({this.OnLoginCall});

  @override
  _Modaluser createState() => _Modaluser();
}
class _Modaluser extends State<Modaluser>{
  final UserLogin userLogin = Get.put(UserLogin());


  TextEditingController controllerEmail=TextEditingController();
  TextEditingController controllerPassword=TextEditingController();
  TextEditingController controllerName=TextEditingController();
  FocusNode focusEmail= FocusNode();
  FocusNode focusPassword= FocusNode();
  FocusNode focusName= FocusNode();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
      child: Column(

       children: [

         Obx(()=>Stack(
           children: [
             userLogin.isLogged.value ?  Column(
               children: <Widget>[

                 TextField(
                   controller: controllerEmail,
                   focusNode: focusEmail,
                   decoration: InputDecoration(
                     icon: Icon(Icons.email),
                     labelText: 'Correo Electrónico',
                   ),
                 ),
                 TextField(
                   obscureText: true,
                   enableSuggestions: false,
                   autocorrect: false,
                   controller: controllerPassword,
                   focusNode: focusPassword,
                   decoration: InputDecoration(
                     icon: Icon(Icons.lock),
                     labelText: 'Contraseña',
                   ),
                 ),
                 Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                         margin: EdgeInsets.only(top: 20),

                         child: RaisedButton(
                           color: Colors.white,
                           shape: new RoundedRectangleBorder(
                             borderRadius: new BorderRadius.circular(30.0),
                           ),
                           onPressed: (){
                             userLogin.isLogged.value=false;
                           },
                           child: Text("Registrarme",style: TextStyle(color: Color(0xffe5454c)),),
                         ),
                       ),
                       Container(
                         margin: EdgeInsets.only(top: 20),

                         child: RaisedButton(
                           color: Color(0xffe5454c),
                           shape: new RoundedRectangleBorder(
                             borderRadius: new BorderRadius.circular(30.0),
                           ),
                           onPressed: () async{
                             userLogin.isLogged.value=true;

                             int counter=0;

                             if(counter==0){

                               var dataJson=  await userLogin.login(controllerEmail.text,controllerPassword.text);

                               print("esta es la respuesta de datajson  ${dataJson}");

                               if(dataJson["status"]==200){
                                 SharedPreferences prefs = await SharedPreferences.getInstance();
                                 prefs.setString("user", jsonEncode(dataJson["user"]));
                                 Toast.show("${dataJson["data"]}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.greenAccent,textColor: Colors.black);
                               }else{
                                 Toast.show("${dataJson["data"]}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.redAccent);
                               }

                               widget.OnLoginCall(dataJson["status"]);
                             }

                           },
                           child: Text("Ingresar",style: TextStyle(color: Colors.white),),
                         ),
                       )
                     ],
                   ),
                 )
               ],
             ):   Column(
               children: <Widget>[
                 TextField(
                   controller: controllerName,
                   focusNode: focusName,
                   decoration: InputDecoration(
                     icon: Icon(Icons.account_circle),
                     labelText: 'Nombres y apellidos',
                   ),
                 ),
                 TextField(
                   controller: controllerEmail,
                   focusNode: focusEmail,
                   decoration: InputDecoration(
                     icon: Icon(Icons.email),
                     labelText: 'Correo Electrónico',
                   ),
                 ),
                 TextField(
                   obscureText: true,
                   enableSuggestions: false,
                   autocorrect: false,
                    controller: controllerPassword,
                    focusNode: focusPassword,
                    decoration: InputDecoration(
                     icon: Icon(Icons.lock),
                     labelText: 'Contraseña',
                   ),
                 ),
                 Container(
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,

                     children: [
                       Container(
                         margin: EdgeInsets.only(top: 20),

                         child: RaisedButton(
                           color: Colors.white,
                           shape: new RoundedRectangleBorder(
                             borderRadius: new BorderRadius.circular(30.0),
                           ),
                           onPressed: (){
                             userLogin.isLogged.value=true;

                           },
                           child: Text("Ingresar",style: TextStyle(color: Color(0xffe5454c)),),
                         ),
                       ),
                       Container(
                         margin: EdgeInsets.only(top: 20),

                         child: RaisedButton(
                           color: Color(0xffe5454c),
                           shape: new RoundedRectangleBorder(
                             borderRadius: new BorderRadius.circular(30.0),
                           ),
                           onPressed: () async{
                             userLogin.isLogged.value=false;

                             int counter=0;

                             if(!EmailValidator.validate(controllerEmail.text)){
                               Toast.show("Ingresa el correo correctamente", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.redAccent);
                               focusEmail.requestFocus();

                               counter=counter+1;
                             }

                             if(controllerPassword.text.length==0){
                               Toast.show("Ingresa una contraseña", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.redAccent);
                               focusPassword.requestFocus();
                               counter=counter+1;

                             }

                             if(controllerName.text.length==0){
                               Toast.show("Ingresar el nombre", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.redAccent);
                               focusName.requestFocus();
                               counter=counter+1;
                             }

                             if(counter==0){

                              var dataJson=  await userLogin.register(controllerEmail.text,controllerName.text,controllerPassword.text);

                              if(dataJson["status"]==200){
                                SharedPreferences prefs = await SharedPreferences.getInstance();
                                prefs.setString("user", jsonEncode(dataJson["user"]));
                                Toast.show("${dataJson["data"]}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.greenAccent,textColor: Colors.black);
                              }else{
                                Toast.show("${dataJson["data"]}", context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP,backgroundColor: Colors.redAccent);
                              }

                              widget.OnLoginCall(dataJson["status"]);
                             }


                           },
                           child: Text("Registrarme",style: TextStyle(color: Colors.white),),
                         ),
                       )
                     ],
                   ),
                 )
               ],
             )
           ],
         ))
       ],
     ),
   );
  }


}