

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/fetchproductlist/fetchproductlist_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/addcustomer/customers_page.dart';
import 'package:inventory_management_system/presentation/screeens/homepage.dart';
import 'package:inventory_management_system/presentation/screeens/profile_page.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/sales_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class MainScreens extends StatefulWidget {
  final int initialIndex; // Add a parameter for the initial index

  // Constructor with optional initialIndex (default to 0)
  MainScreens({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  late ValueNotifier<int> _selectedIndex;

  @override
  void initState() {
    super.initState();
  
    _selectedIndex = ValueNotifier<int>(widget.initialIndex);

    print("==============================${_selectedIndex} ");

    if (_selectedIndex.value ==0) {

      context.read<FetchProductListBloc>().add(FetchProductListInitialEvent()); 
      
    }
  }

  // Define the pages for the navigation bar
  static final List<Widget> _pages = <Widget>[
    HomePage(),
    SalesPage(),
    CustomersPage(),
    const ProfilePage(),
  ];

  @override
  void dispose() {
    _selectedIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (context, value, child) {
          return _pages[value];
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 5,
              activeColor: Colors.black,
              iconSize: 20,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Products',
                ),
             
                 GButton(
                  icon: Icons.trending_up,
                  text: 'Sales',
                ),
                GButton(
                  icon: CupertinoIcons.person_add,
                  text: 'Customers',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex.value,
              onTabChange: (index) {
                _selectedIndex.value = index;
              },
            ),
          ),
        ),
      ),
    );
  }
}
