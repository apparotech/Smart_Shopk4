import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_shopk4/utils/firebase.dart';

class AuthService {

  // create a firebase user
  Future<bool> createUser(

    String? email,
    String? password,
    String? name,
    User? user
  ) async {
    var res = await  firebaseAuth.createUserWithEmailAndPassword(
        email: '$email', password: '$password'
    );

    if(res.user != null) {
       saveUserToFirestore(name!, email!, user!);
       return true;

    } else {
      return false;
    }
  }
// this will save user  details to firestore
  void saveUserToFirestore(
      String name,
      String email,
      User user
      )  async {
    await userRef.doc(user.uid).set({
      'userName' : name,
      'email' : email,
      'time' : Timestamp.now(),
       'id': user.uid,
        'bio' : '',
       'photoUrl' : user.photoURL ?? '',
       'gender' : '',



    });

  }

  // method to login a user with his email and password

 Future<bool> loginUser(String? email, String? password)  async {

    var res = await firebaseAuth.signInWithEmailAndPassword(
        email: '$email',
        password: '$password',
    );

    if(res.user != null ) {
      return true;
    } else {
      return false;
    }

 }

 void logout() async {
     await firebaseAuth.signOut();
 }

}
