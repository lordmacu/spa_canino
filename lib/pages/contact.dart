import 'package:flutter/material.dart';
class Contact extends StatelessWidget{
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color(0xff41A099),

        title: Text("Contacto"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            children: [

              Container(
                padding: EdgeInsets.only(left: 20,right: 20),
                child:  Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(

                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Asunto"
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                      ),
                      Container(

                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Email"
                          ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                      ),
                     Container(
                       child:  TextFormField(

                         maxLines: 3,
                         decoration: InputDecoration(

                           hintText: "Descripción",

                         ),
                         // The validator receives the text that the user has entered.
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please enter some text';
                           }
                           return null;
                         },
                       ),
                     ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: RaisedButton(
                          color:  Color(0xff41A099),
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),

                          onPressed: () {

                          },
                          child: Text('Enviar',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
}