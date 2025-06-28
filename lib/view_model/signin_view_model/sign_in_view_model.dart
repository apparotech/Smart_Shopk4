import 'package:flutter/material.dart';
import 'package:smart_shopk4/Pages/HelperFunction/Navigation_Helper.dart';
import 'package:smart_shopk4/Pages/mainScreen/TabScreen.dart';
import 'package:smart_shopk4/services/auth_service.dart';

class SignInViewModel extends ChangeNotifier {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(); // for the show the  Snackbar from outside
  final GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Validate all fields & Save the form
  bool validate = false;
  bool loading = false;

  String? email, password;
  AuthService auth  = AuthService();

  void login(BuildContext context) async {

    FormState from = formKey.currentState!;
    from.save();

    if(!from.validate()) {
      validate = true;
      notifyListeners();
      return showInSnackBar("Plase fix the error in red before submitting", context);

    } else {
      loading = true;
      notifyListeners();
      try {
        bool success= await auth.loginUser(
            email,
            password

        );
        print(success);
        if(success) {
          showInSnackBar('Sign in SuccessFull', context);
          NavigationHelper.nextPage(context,TabScreen());
        }
      } catch (e){
        loading = false;
        notifyListeners();
        print(e);
        showInSnackBar('${auth.handleFirebaseAuthError(e.toString())}', context);
      }
      loading = false;
      notifyListeners();


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

  void showInSnackBar(String  value, context) {

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));

  }

}