import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferEarnController extends GetxController{
  String name = "";
  String email = "";
  String phoneNum = "";
  String jobTitle = "";
  String company = "";
void init(){
  loadDetails();
  super.onInit();
}

  void loadDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name') ?? '';
    email = prefs.getString('email') ?? '';
    phoneNum = prefs.getString('phone_no') ?? '';
    jobTitle = prefs.getString('job_title') ?? '';
    company = prefs.getString('company') ?? '';
    print("name is $name");
  }

}