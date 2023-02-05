import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:insta_clone_2/models/post.dart';
import 'package:insta_clone_2/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(String description,
    String uid,
    String username,
    String profImage,
    Uint8List file) async {
    
  String res ="Some error occured";
  try{
   String photoUrl = await StorageMethods().uploadImagetoStorage('posts', file, true);
   String postId = Uuid().v1();
   Post post = Post(
    description: description,
    postId: postId, 
    uid: uid, 
    datePublished: DateTime.now(), 
    username: username, 
     postUrl: photoUrl, 
     profImage: profImage,
     likes :[]);

     _firestore.collection("posts").doc(postId).set(post.toJson(),); 

     res ="success";
  }
  catch(err){
     res = err.toString();
  }
  return res; 
  }
}