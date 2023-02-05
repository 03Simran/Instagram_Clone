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
                  Text('Delete post')
                ],)
            ));
          }, icon: Icon(Icons.more_vert)),
        ],),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal:10),
        child: SizedBox(height:MediaQuery.of(context).size.height*0.35,
        width:double.infinity,
        child : Image.network('https://media.sproutsocial.com/uploads/2022/03/Instagram-Carousels.svg',
        fit:BoxFit.cover,),
        ),
      ),
      Row(children: [
         IconButton(icon: Icon(Icons.favorite,color: Colors.red,),onPressed: (){},),

         IconButton(icon: Icon(Icons.comment,),onPressed: (){},),

         IconButton(icon: Icon(Icons.send),onPressed: (){},),
          
         Expanded(child: Align(alignment:Alignment.bottomRight,
         child:IconButton(icon: Icon(Icons.bookmark),onPressed: () {
           
         },),))

      ],),

      //Container(padding:)
      ],)
    );
  }
}