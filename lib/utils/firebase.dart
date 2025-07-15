
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;

final Uuid uuid = Uuid();


// Collection refs

CollectionReference userRef = firestore.collection('users');
CollectionReference postRef = firestore.collection('posts');
CollectionReference commentRef =firestore.collection('comments');
CollectionReference followersRef =firestore.collection('followers');
CollectionReference followingRef =firestore.collection('following');
CollectionReference chatRef = firestore.collection("chats");
CollectionReference chatIdRef = firestore.collection('chatIds');


// Storage refs

Reference profilePic = storage.ref().child('profilePic');
Reference posts = storage.ref().child('posts');



