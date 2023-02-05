import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone_2/utils/colors.dart';
import 'package:insta_clone_2/widgets/post_card.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle:false,
        title: SvgPicture.asset('lib/assets/images/ic_instagram.svg',
              color: primaryColor,
              height :32,),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.messenger_outline),)
              ],
      ),
      body:PostCard(),
    );
  }
}