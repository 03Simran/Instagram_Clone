
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone_2/resources/auth_method.dart';
import 'package:insta_clone_2/utils/colors.dart';
import 'package:insta_clone_2/utils/utils.dart';
import 'package:insta_clone_2/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screen_layout.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdcontroller = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;

  Uint8List? _image;
  @override
  void dispose(){
    super.dispose();
    _emailController.dispose();
    _pwdcontroller.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    
   Uint8List im = await pickImage(ImageSource.gallery);
   setState(() {
     _image=im;
   });
  }

  void signUpUser() async {
    setState(() {
      _isLoading=true;
    });
    
    String res = await AuthMethods().signUpUser(
    email: _emailController.text, 
    username: _usernameController.text, 
    password:_pwdcontroller.text, 
    bio: _bioController.text,
    file: _image!); 
    setState(() {
      _isLoading=false;
    });
    if (res == 'success')  {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context)=>const ResponsiveLayout (
        mobileScreenLayout: MobileScreenLayout() ,
       webScreenLayout: WebScreenLayout(),)));
    }                         
    if (res!='success'){
      showSnackBar(res, context);
      
    }                       
  }
  void navigatetoLogIn(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(
        child: SizedBox(
          child: ListView(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                   
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      
                      Flexible(child: Container(),flex : 2),
                      //svg image 
                      
                        SvgPicture.asset('lib/assets/images/ic_instagram.svg',
                        color: primaryColor,
                        height :64,),
                      
                      SizedBox(height: 10,),
                      Stack(children: [
                        _image!=null?CircleAvatar(
                          radius: 64 ,
                          backgroundImage: MemoryImage(_image!),
                        )
                        : const CircleAvatar(
                          radius: 64 ,
                          backgroundImage: NetworkImage('https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'),
                        ),
                        Positioned(
                          bottom:-10,
                          left :80,
                          
                          child: IconButton(onPressed: selectImage,
                        icon : Icon(Icons.add_a_photo)))
                      ],),
                      SizedBox(height: 10,),
                      TextFieldInput(
                          textEditingController: _usernameController,
                           hintText: "Enter your username",
                            textInputType: TextInputType.text,),
                      SizedBox(height: 30,),
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
                        TextFieldInput(
                          textEditingController: _bioController,
                           hintText: "Enter your bio",
                            textInputType: TextInputType.text,),
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
                            onPressed: signUpUser,
                            style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                  ),
                            child: _isLoading ? const Center(child:CircularProgressIndicator(
                              color: mobileBackgroundColor,
                            ),) 
                                    :const Text('Sign in',
                           style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                           ),),),
                        ),
                        SizedBox(height: 12,),
                        
                
                        
                
                        SizedBox(height: 24,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(onPressed:navigatetoLogIn, child: Text('Login'))
                          ],
                        )
                    ],
                  ),
            
            
            
          ),
        ),
      
    );
  }
}