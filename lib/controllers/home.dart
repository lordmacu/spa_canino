import 'package:get/get.dart';


class Home extends GetxController{

  var banners = [].obs;
  var isOpenMenu = false.obs;
  var showPanel = 1.obs;


  void closeMenu(){
    this.isOpenMenu.value=false;
  }


  void setPanel(number){
   this.showPanel.value=number;
  }
  void openMenu(){
    this.isOpenMenu.value=true;
  }

  @override
  void onInit() { // called immediately after the widget is allocated memory

    banners.add("assets/banner1.png");
    banners.add("assets/banner2.png");
    banners.add("assets/banner3.png");


    super.onInit();
  }


}