import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post{
  final String description;
  final String postId;
  final String uid;
  final datePublished;
  final String username;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.description,
    required this.postId,
    required this.uid,
    required this.datePublished,
    required this.username,
    required this.likes,
    required this.postUrl,
    required this.profImage,

});

Map <String,dynamic> toJson()=>{
         'username' : username,
         'postUrl': postUrl,
         'description':description,
         'uid':uid,
         'datePublished':datePublished,
         'likes':likes,
         'profImage':profImage,
         'postId' : postId,

};

static Post fromSnap(DocumentSnapshot snap){
  var snapshot = snap.data() as Map<String,dynamic>;

  return Post(
   username: snapshot['username'],
   postId: snapshot['postid'],
    datePublished: snapshot['datePublished'],
     uid: snapshot['uid'],
     description: snapshot['description'],
      likes: snapshot[' likes'], 
      postUrl: snapshot['postUrl'],
      profImage: snapshot[' profImage']);
}
}