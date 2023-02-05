import 'dart:html';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone_2/models/users.dart' as models;
import 'package:insta_clone_2/utils/colors.dart';

import 'package:insta_clone_2/resources/firestore_methods.dart';

import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/utils.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool isLoading = false;
  Uint8List? _file ;
  TextEditingController _descriptionController= TextEditingController();
  void dispose(){
    super.dispose();
    _descriptionController.dispose();
  }


 void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    
    try {
      
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        uid,
        username,
        profImage,
        _file!
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });
        showSnackBar(
          "Posted",context
        );
        clearImage();
      } else {
        showSnackBar(res, context);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        err.toString(),context,
      );
    }
  }

  void clearImage(){setState(() {
      _file = null;
    });}

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: ( context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: [
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),]
          
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
   final UserProvider user = Provider.of<UserProvider>(context);
    
      return _file==null? Center(
        child:IconButton(icon: const Icon(Icons.upload),
        onPressed:(() => selectImage(context))))
        : Scaffold(
      appBar: AppBar(
      backgroundColor: mobileBackgroundColor,
      leading: IconButton(icon: Icon(Icons.arrow_back),
      onPressed: clearImage,),
      title: Text("Post to"),
      centerTitle: false,
      actions: [
        TextButton(
          onPressed:()=>postImage(user.getUser.uid, user.getUser.username, user.getUser.photoUrl), 
          child: Text(
                 "Post",
                 style :TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold)),
        )
      ],
      ),
      body: Column(children:[
          isLoading?LinearProgressIndicator():Container() ,
       Row(children: [
        CircleAvatar(backgroundImage: NetworkImage('https://cdn.siasat.com/wp-content/uploads/2022/07/Instagram_1.jpg'),
        ),
        SizedBox(width:MediaQuery.of(context).size.width*0.7,
        child : TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: 'Write a caption',
          ),
          maxLines: 4,
        )),
      SizedBox(
           height:45,
           width:45,
           child:AspectRatio(aspectRatio:487/451,
           child : Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: MemoryImage(_file!),
              fit: BoxFit.fill,
              alignment: FractionalOffset.topCenter,)
            ),
           ))
        ),
        Divider(),

      ],)]),);
  }
}