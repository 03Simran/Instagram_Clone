import "package:flutter/material.dart";
import 'package:insta_clone_2/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(vertical: 10),
      child:Column(children: [
        Container(padding:EdgeInsets.symmetric(vertical:4,horizontal: 30).copyWith(right: 0),
      ),
      Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Row(children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage("https://cdn.siasat.com/wp-content/uploads/2022/07/Instagram_1.jpg"),
          ),
          Expanded(child: Padding(padding: EdgeInsets.only(left:8,),
          child:Column(mainAxisSize:MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Text('username_123',style: TextStyle(fontWeight: FontWeight.bold),)
          ],)),),
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context)=> Dialog(
              child:ListView(
                padding:EdgeInsets.symmetric(vertical:16),
                shrinkWrap: true,
                children: [
                  
                ],)
            ));
          }, icon: Icon(Icons.more_vert)),
        ],),
      )
      ],)
    );
  }
}