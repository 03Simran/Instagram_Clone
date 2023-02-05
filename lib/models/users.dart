import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User{
  final String email;
  final String photoUrl;
  final String uid;
  final String bio;
  final String username;
  final List followers;
  final List  following;

   User({
    required this.email,
    required this.bio,
    required this.photoUrl,
    required this.uid,
    required this.username,
    required this.followers,
    required this.following,
});

Map <String,dynamic> toJson()=>{
         'username' : username,
         'photoUrl': photoUrl,
         'email':email,
         'uid':uid,
         'bio':bio,
         'followers':followers,
         'following':following,
};

static User fromSnap(DocumentSnapshot snap){
  var snapshot = snap.data() as Map<String,dynamic>;

  return User(
   email: snapshot['username'],
   bio: snapshot['bio'],
    photoUrl: snapshot['photoUrl'],
     uid: snapshot['uid'],
     username: snapshot['username'],
      followers: snapshot['followers'], 
      following: snapshot['following'],);
}
}