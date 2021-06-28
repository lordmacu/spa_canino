import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spa_canino/controllers/pet.dart';

import 'package:image_picker/image_picker.dart';

import 'package:get/get.dart';
import 'package:spa_canino/models/DropdownValue.dart';
import 'package:spa_canino/pages/contact.dart';
import 'package:spa_canino/pages/ui/modalUser.dart';
//import 'package:flutter_material_pickers/flutter_material_pickers.dart';

import 'package:toast/toast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_picker/flutter_picker.dart';


class Pets extends StatelessWidget {
  final Pet pet = Get.put(Pet());
  BuildContext dialogContext; // <<----

  showLogin(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("user") == null) {
      dialogContext = context;
      Alert(
          context: context,
          title: "",
          style: AlertStyle(
              alertPadding: EdgeInsets.only(top: 0),
              titleStyle: TextStyle(height: 0)),
          content: Modaluser(
            OnLoginCall: (int status) async {
              if (status == 200) {
                pet.clearForm();
                pet.getPets();
              }
              Navigator.pop(dialogContext);
            },
          ),
          buttons: []).show();
    } else {
      pet.clearForm();

      pet.getPets();
    }
  }

  showRazas(context) {
  /*  showMaterialScrollPicker(
        context: context,
        title: 'Seleccione la raza',
        items: pet.razas,
        cancelText: "Cancelar",
        confirmText: "Seleccionar",
        selectedItem: pet.petRaza.value,
        onChanged: (value) {
          print("aquii esta el valur  ${value}");
          pet.petRaza.value = value;
        });*/

    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata:pet.razas),
        changeToFirst: true,
        hideHeader: false,

        confirmText: "Confirmar",
        cancelText: "Cancelar",
        onConfirm: (Picker picker, List value) {

          pet.petRaza.value = picker.getSelectedValues()[0];

        }
    ).showModal(context);
  }

  showTypes(context) {


    new Picker(
        adapter: PickerDataAdapter<String>(pickerdata:pet.types),
        changeToFirst: true,
        hideHeader: false,
        confirmText: "Confirmar",
        cancelText: "Cancelar",
        onConfirm: (Picker picker, List value) {

          pet.petType.value = picker.getSelectedValues()[0];

        }
    ).showModal(context);

  }
  Future<File> file;

  deletePet(context,petId){
    Alert(
      context: context,
      type: AlertType.warning,
      title: "Borrar mascota",
      desc: "¿Estas seguro de borrar esta mascota?",
      buttons: [
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "Si, Borrarla",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {

           await  pet.deletePet(petId);
  pet.clearForm();
           pet.getPets();

           pet.controller.value.close();

            Navigator.pop(context);
          },
          color: Colors.redAccent,

        )
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Obx(()=>ModalProgressHUD(inAsyncCall: pet.isLoading.value, child: SlidingUpPanel(
      backdropEnabled: true,
      controller: pet.controller.value,
      maxHeight: 500,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(10), topLeft: Radius.circular(10)),
      minHeight: 0,
      header: Container(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.drag_handle,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
      panel: Scaffold(
        bottomNavigationBar:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            pet.petId!=0 ? Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  deletePet(context,pet.petId);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      color: Color(0xffe5454c),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Borrar mascota",
                        style: TextStyle(color: Color(0xffe5454c)),
                      ),
                    ),
                  ],
                ),
              ),
            ): Container(),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: RaisedButton(
                color: Color(0xffe5454c),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  if (pet.formKey.value.currentState.validate()) {
                    pet.postPet();
                    pet.controller.value.close();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      color: Colors.white,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "Guardar mascota",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Form(
                key: pet.formKey.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      child: TextFormField(
                        controller: pet.nameController.value,
                        decoration: InputDecoration(hintText: "Nombre mascota"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese el nombre de la mascota';
                          }
                          return null;
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      child: TextFormField(
                        controller: pet.colorController.value,

                        decoration: InputDecoration(hintText: "Color mascota"),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese el color de la mascota';
                          }
                          return null;
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color(0xff41A099),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2025),
                          );
                          if (picked != null) {
                            pet.petBithday.value =
                            "${picked.day}-${picked.month}-${picked.year}";
                            pet.petBithdayValue.value =
                            "${picked.toIso8601String()}";
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.calendar_today,
                                color: Colors.white,
                              ),
                            ),
                            Obx(() => Text(
                              pet.petBithday.value.length > 0
                                  ? pet.petBithday.value
                                  : 'Nacimiento',
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color(0xff41A099),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          showRazas(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.pets,
                                color: Colors.white,
                              ),
                            ),
                            Obx(() => Text(
                              pet.petRaza.value.length > 0
                                  ? pet.petRaza.value
                                  : 'Raza',
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    Container(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color(0xff41A099),
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          showTypes(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text(
                              pet.petType.value.length > 0
                                  ? pet.petType.value
                                  : 'Tipo de mascota',
                              style: TextStyle(color: Colors.white),
                            ))
                          ],
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: RaisedButton(
            color: Color(0xffe5454c),
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
            onPressed: () {
              pet.controller.value.open();
              showLogin(context);
              //cart.addCart();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pets,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Agregar mascota",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "Mis mascotas",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<Pet>(
          builder: (_dx) => _dx.pets.length > 0
              ? ListView.builder(
            itemCount: _dx.pets.length,
            itemBuilder: (context, index) {
              var image=_dx.pets[index].image.split("/");
              print("aqui se esta pingando ${image.length}");
              return Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    image.length==5 ? GestureDetector(
                      onTap: () async {
                        var image= await ImagePicker.pickImage(source: ImageSource.gallery);

                        final bytes = await image.readAsBytes();

                        pet.startUpload(bytes,image,_dx.pets[index].id);
                      },
                      child: Container(
                        width: 150,
                        height: 100,

                        padding: EdgeInsets.only(top: 30,bottom: 30,left: 10,right: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),

                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              child: Text("Agregar Imágen"),
                            ),
                            Container(
                              child: Icon(Icons.add),
                            )
                          ],
                        ),
                      ),
                    ) :GestureDetector(
                      onTap: () async {
                        var image= await ImagePicker.pickImage(source: ImageSource.gallery);

                        final bytes = await image.readAsBytes();

                        pet.startUpload(bytes,image,_dx.pets[index].id);
                      },
                      child: Container(
                        width: 150,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(_dx.pets[index].image,fit: BoxFit.cover,),
                        ),
                      ),
                    ),
                    Expanded(
                        child: GestureDetector(
                          onTap: (){
                            print("aquii esta el objeto ${_dx.pets[index]}");
                            pet.clearForm();
                            pet.getPets();

                            pet.nameController.value.text=_dx.pets[index].name;
                            pet.colorController.value.text=_dx.pets[index].color;
                            pet.petRaza.value=_dx.pets[index].razaText;
                            pet.petType.value=_dx.pets[index].typeText;
                             pet.petBithday.value=_dx.pets[index].birthday;
                            pet.petBithdayValue.value=_dx.pets[index].birthday;
                            pet.petId.value=_dx.pets[index].id;
                            pet.controller.value.open();

                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(left: 10,top: 20,bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${_dx.pets[index].name}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text("${_dx.pets[index].typeText}"),
                                ),
                                Container(
                                  child: Text("${_dx.pets[index].razaText}"),
                                )
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              );
            },
          )
              : Center(
            child: Text("No tienes mascotas"),
          ),
        ),
      ),
    )));
  }
}
