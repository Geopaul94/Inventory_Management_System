import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/firebase_options.dart';
import 'package:inventory_management_system/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/login_page.dart';
import 'package:inventory_management_system/presentation/screeens/authentication/signup_page.dart';
import 'package:inventory_management_system/presentation/screeens/image_picker.dart';
import 'package:inventory_management_system/presentation/screeens/main_screens.dart';
import 'package:inventory_management_system/presentation/screeens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
       
      
        BlocProvider(create: (context) => AddPostBloc()),
      ],



 child: MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Inventory Management System',
      theme: ThemeData(),
      home: SplashScreen(),
     ) );
  }
}
