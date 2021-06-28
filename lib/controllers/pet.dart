import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:spa_canino/models/Banner.dart';
import 'package:spa_canino/models/Pet.dart' as p;
import 'package:spa_canino/models/DropdownValue.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'dart:convert';
import 'dart:io' as Io;
class Pet extends GetxController{


  var controller= PanelController().obs;
  final formKey = GlobalKey<FormState>().obs;

  var petBithday= "".obs;
  var petBithdayValue= "".obs;


  var petRaza= "".obs;
  var petType= "".obs;
  var petId= 0.obs;
  var baseUrl="http://54.232.24.241";
  var pets= [].obs;
  File tmpFile;
  var file= null.obs;
  var nameController= TextEditingController().obs;
  var colorController= TextEditingController().obs;

  List<String> razas =<String>[].obs;
  List<String> types =<String>[].obs;


  var status = ''.obs;
   var  base64Image= "".obs;
   var errMessage = ''.obs;
   var isLoading = false.obs;


  clearForm(){
    print("afasf");
    nameController.value.text="";
    colorController.value.text="";
    petRaza.value="";
    petType.value="";
    petBithday.value="";
    petBithdayValue.value="";
    petId.value=0;
    update();
  }
  postPet() async{
    isLoading.value=true;
    print("aquii");
    var popularsLocal=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = jsonDecode(prefs.getString("user"));

    var url = Uri.parse('${baseUrl}/api/postPet');
    var response = await http.post(url,body: {
      "user_id":"${json["id"]}",
      "name":"${nameController.value.text}",
      "color":"${colorController.value.text}",
      "raza":"${petRaza.value}",
      "type":"${petType.value}",
      "petBithday":"${petBithday.value}",
      "petBithdayValue":"${petBithdayValue.value}",
      "petId":"${petId.value}",
      });

    isLoading.value=false;


    await getPets();


  }
  String base64Encode(List<int> bytes) => base64.encode(bytes);


  startUpload(bytes,file,id)  async{

     String fileName = file.path.split('/').last;
    upload(fileName,base64Encode(bytes),id);
  }

  deletePet(pet) async{
    var popularsLocal=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(prefs.getString("user")!=null) {

      var json = jsonDecode(prefs.getString("user"));

      var url = Uri.parse('${baseUrl}/api/deletePet');
      var response = await http.post(url, body: {"petId": "${pet}"});


    }
  }

  upload(String fileName,base,id)  async{
    isLoading.value=true;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var json = jsonDecode(prefs.getString("user"));




    http.post('${baseUrl}/api/setImage', body: {
      "name": fileName,

      "image": base,
      "id": "${id}",
      "user_id":"${json["id"]}"
    }).then((result) {
      print("este es el result ${result.body}");
      isLoading.value=false;

      getPets();

    }).catchError((error) {
      print("este es el error ${error}");
      isLoading.value=false;

    });
  }

  getPets() async{
    isLoading.value=true;

    var popularsLocal=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();

    pets.value=[];


    if(prefs.getString("user")!=null){
      print("aquii estoy  las mascotas");
      var json = jsonDecode(prefs.getString("user"));

      var url = Uri.parse('${baseUrl}/api/getMyPets');
      var response = await http.post(url,body: {"user_id":"${json["id"]}"});

      var jsonData= jsonDecode(response.body);

      print("datass  ${jsonData["razas"]}");

      razas=[];
      types=[];

      jsonData["razas"].forEach((item){
        razas.add(item);
      });

      jsonData["types"].forEach((item){
        types.add(item);
      });

      jsonData["data"].forEach((item){


        p.Pet petItem= p.Pet();
        petItem.name= item["name"];
        petItem.id= item["id"];
        petItem.image= item["image"];
        petItem.user_id= int.parse(item["user_id"]);
        petItem.raza= item["raza"]["id"];
        petItem.razaText= item["raza"]["name"];
        petItem.status= item["status"]["id"];
        petItem.statusText= item["status"]["name"];
        petItem.color= item["color"];
        petItem.birthday= item["birthday"];
        petItem.type= item["type"]["id"];
        petItem.typeText= item["type"]["name"];

        popularsLocal.add(petItem);
      });
      pets.value=popularsLocal;
    }
    isLoading.value=false;

    update();

  }

  @override
  void onInit() { // called immediately after the widget is allocated memory

     controller= PanelController().obs;
    super.onInit();
  }


}