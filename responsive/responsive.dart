import 'package:flutter/material.dart';
import 'package:insta_clone_2/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'dimensions.dart';
class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResponsiveLayout({Key? key,
   required this.webScreenLayout,
   required this.mobileScreenLayout,
    }) : super(key:key) ;

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override 
  void initState(){
    super.initState();
    addData();
  }

  addData() async{
    UserProvider _userProvider=Provider.of(context,listen: false);
    await _userProvider.refreshUser();
  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ( context , constraints){
        if(constraints.maxWidth>webScreenSize){
          // web screen layout
          return widget.webScreenLayout;
        }
        // mobilescreenlayout 
        return widget.mobileScreenLayout;
      }
    );
  }
}
