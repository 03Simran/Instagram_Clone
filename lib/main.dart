import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_2/providers/user_provider.dart';
import 'package:insta_clone_2/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'screens/signup_screen.dart';
import 'responsive/responsive.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/web_screen_layout.dart';
import 'utils/colors.dart';
import 'dart:html';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options:const FirebaseOptions(
        apiKey: 'AIzaSyCCQ3PT3SdEZ10RVyKKUrb3fBER7beWi1s', 
        appId: '1:558104548690:web:92fb406a2a93c751d8968b',
         messagingSenderId: '558104548690',
          projectId: 'instagramclone-2f266',
          storageBucket:"instagramclone-2f266.appspot.com", ),
    );
  }
  else{
  await Firebase.initializeApp(); }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>UserProvider(),)
      ],
      child: MaterialApp(
        title: 'Instagram Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
         
    
         home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.active){
              if(snapshot.hasData){
                return const ResponsiveLayout (
          mobileScreenLayout: MobileScreenLayout() ,
         webScreenLayout: WebScreenLayout(),);
              }
              else if(snapshot.hasError){
                return Center(child:Text('$snapshot.error')) ;
              }
    
            }
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child : CircularProgressIndicator(color:primaryColor)
              );
            }
            return const SignUpScreen() ;
          },)
         
          
        ),
    );}
}

