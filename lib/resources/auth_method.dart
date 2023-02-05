import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_2/models/users.dart' as model;
import 'package:insta_clone_2/resources/storage_methods.dart';

class AuthMethods{

  final FirebaseAuth _auth =FirebaseAuth.instance ;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap) ;
  }

  //signup user

  Future<String> signUpUser({
    required String email,
    required String username,
    required String password,
    required String bio,
    required Uint8List file,
  }) async{
    String res = "Some error found" ;
    try{
       if(email.isNotEmpty|| password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file!=null ){
        //register user
       UserCredential cred=await  _auth.createUserWithEmailAndPassword(email: email, password: password);

       // add user to our database

       print(cred.user!.uid);

       String photoUrl = await StorageMethods().uploadImagetoStorage('profilepics', file, false);

       model.User user = model.User(
        username:username ,
        bio:bio,
        uid:cred.user!.uid,
        email:email,
        followers:[],
        following:[],
        photoUrl:photoUrl,

       ); 

       await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

      
      res = "success";

       }
    } 
    catch(err){
         res = err.toString();
    }
    return res;
  }
 ////loginuser 

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }
}

 
