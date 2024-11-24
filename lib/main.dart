import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/data/models/sales_model.dart';
import 'package:inventory_management_system/data/repository/customer_details/cusomer_data.dart';
import 'package:inventory_management_system/firebase_options.dart';
import 'package:inventory_management_system/presentation/bloc/add_post/add_post_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/add_product/addproduct_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/login_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/authentication/bloc/signup_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/category/category_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/customers/customers_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/fetchproductlist/fetchproductlist_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/sales_bloc/sales_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/samplepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  //  final ConnectivityService connectivityService = ConnectivityService();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392, 802),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AddPostBloc()),
            BlocProvider(create: (context) => AddProductBloc()),
            BlocProvider(create: (context) => FetchProductListBloc()),
            BlocProvider(create: (context) => CustomersBloc()),
            BlocProvider(create: (context) => SalesBloc()),
            BlocProvider(create: (context) => CategoryBloc()),
            BlocProvider(create: (context) => SignUpBloc()),
            BlocProvider(create: (context) =>  CustomerSearchBloc(FirebaseFirestore.instance)),
            BlocProvider(create: (context) => LoginBloc()),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Inventory Management System',
              theme: ThemeData(),
              home:  SplashScreen()),
        );
      },
    );
  }
}
