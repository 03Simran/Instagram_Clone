// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone_2/utils/colors.dart';
import 'package:insta_clone_2/utils/utils.dart';
import 'package:insta_clone_2/widgets/text_field_input.dart';
import '../resources/auth_method.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();

  bool _isLoading = false;

  
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _pwdcontroller.dispose();
  }

  void loginUser() async{ 
    setState(() {
      _isLoading=true;
    });
   
    String res = await AuthMethods().loginUser(email: _emailController.text,password: _pwdcontroller.text);

    if(res=="success"){
     Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context)=>const ResponsiveLayout (
        mobileScreenLayout: MobileScreenLayout() ,
       webScreenLayout: WebScreenLayout(),)));
    }
    else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading=false;
    });
  } 

  void navigatetoSignUp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 32),
          width : double.infinity,
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              Flexible(child: Container(),flex : 2),
              //svg image 
              SvgPicture.asset('lib/assets/images/ic_instagram.svg',
              color: primaryColor,
              height :64,),
              SizedBox(height: 64,),
              // username textfield 
                TextFieldInput(
                  textEditingController: _emailController,
                   hintText: "Enter your email",
                    textInputType: TextInputType.emailAddress,),
              SizedBox(height: 30,),
              // password textfield 
              TextFieldInput(
                textEditingController: _pwdcontroller, 
                hintText: "Enter your password", 
                textInputType: TextInputType.visiblePassword,
                isPass: true,),
                SizedBox(height: 30,),
                Container( 
                  width: 500,
                  height : 50,
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    
                   color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: loginUser, 
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
  ), 
                    child: _isLoading ? const CircularProgressIndicator(
                      color: Colors.black,
                    )
                    :Text('Log in',
                   style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                   ),),),
                ),
                SizedBox(height: 12,),
                Row(children: [
                  Text('Forgot your login details?'),

                  TextButton(onPressed: (){}, child:Text('Get help logging in'))
                ],mainAxisAlignment: MainAxisAlignment.center,),

                Center(child: Text('OR')),

                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.access_time_rounded)),
                    TextButton(onPressed: (){}, child: Text("LOGIN WITH FACEBOOK"))
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),

                SizedBox(height: 64,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?'),
                    TextButton(onPressed:navigatetoSignUp, child: Text('Sign Up'))
                  ],
                )
            ],
          )
        ),
      ),
    );
  }
}