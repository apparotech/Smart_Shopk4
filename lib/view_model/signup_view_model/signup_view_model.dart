
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/mainScreen/TabScreen.dart';
import 'package:smart_shopk4/services/auth_service.dart';

class SignupViewModel extends ChangeNotifier {
final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? username, email , password, cPassword;
  bool validate = false;
  bool loading = false;
  FocusNode usernameFN = FocusNode();
  FocusNode emailFN = FocusNode();
  FocusNode passFN = FocusNode();
  FocusNode CPassFN = FocusNode();
  AuthService auth = AuthService();


register(BuildContext context)  async {
  FormState form = formKey.currentState!;
  form.save();
  if(!form.validate()) {
       validate = true;
       notifyListeners();
       showInSnackBar('Plase fix the errors in red before submitting', context);
  } else {
    if(password == cPassword) {
      loading = true;
      notifyListeners();
       try {
         bool success = await  auth.createUser(
           name: username,
           email: email,
           password: password
         );
         print(success);
         if(success) {
           showInSnackBar('SignUP Successfull', context);
         NavigationHelper.nextPage(context, TabScreen());
         }
       } catch(e) {
         loading = false;
         notifyListeners();
         print(e);
         showInSnackBar(
             '${auth.handleFirebaseAuthError(e.toString())}', context);
       }
    } else {
      showInSnackBar("The password does not match", context);
    }
  }
}
  setEmail(val) {
    email = val;
    notifyListeners();
  }

  setPassword(val) {
    password = val;
    notifyListeners();
  }


  setUserName(val) {
    username = val;
    notifyListeners();
  }

  setcPassword(val) {
  cPassword = val;
  }

  void showInSnackBar(String value, context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
  }


 }