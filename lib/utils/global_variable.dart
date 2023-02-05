import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_2/screens/add_post_screen2.dart';

import '../screens/feed_screen.dart';
//import 'package:instagram_clone_flutter/screens/add_post_screen2.dart';
//import 'package:instagram_clone_flutter/screens/feed_screen.dart';
//import 'package:instagram_clone_flutter/screens/profile_screen.dart';
//import 'package:instagram_clone_flutter/screens/search_screen.dart';



List<Widget> homeScreenItems = [
  const FeedScreen(),
  //const Text("FeedScreen"),
  //const SearchScreen(),
  const Text("SearchScreen"),
  //const Text('PostScreen'),
  AddPostScreen(),
  const Text('notifications'),
  //ProfileScreen( uid: FirebaseAuth.instance.currentUser!.uid,),
  Text('ProfileScreen'),
];