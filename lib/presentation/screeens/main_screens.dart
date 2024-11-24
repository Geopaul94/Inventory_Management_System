


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/fetchproductlist/fetchproductlist_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/addcustomer/customers_page.dart';
import 'package:inventory_management_system/presentation/screeens/category/category_page..dart';
import 'package:inventory_management_system/presentation/screeens/profile_page.dart';
import 'package:inventory_management_system/presentation/screeens/reporsts/reportpage.dart';
import 'package:inventory_management_system/presentation/screeens/sales_screen/sales_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class MainScreens extends StatefulWidget {
  final int initialIndex; // Add a parameter for the initial index

  // Constructor with optional initialIndex (default to 0)
  const MainScreens({super.key, this.initialIndex = 0});

  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  late ValueNotifier<int> _selectedIndex;

  @override
  void initState() {
    
    super.initState();
  
    _selectedIndex = ValueNotifier<int>(widget.initialIndex);

    print("==============================$_selectedIndex ");

    if (_selectedIndex.value ==0) {

      context.read<FetchProductListBloc>().add(FetchProductListInitialEvent()); 
      
    }
  }

  // Define the pages for the navigation bar
  static final List<Widget> _pages = <Widget>[
    const CategoryPage(),
    const SalesPage(),
    const CustomersPage(),
     const ReportPage(),

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
              gap: 4,
              activeColor: Colors.black,
              iconSize: 20,
            tabBorderRadius:  10,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: const Color.fromARGB(91, 8, 95, 235),
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
                  icon: CupertinoIcons.text_aligncenter,
                  text: 'Reports',
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
