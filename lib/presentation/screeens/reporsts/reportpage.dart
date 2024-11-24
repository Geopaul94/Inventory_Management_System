import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/presentation/screeens/reporsts/item_report.dart';
import 'package:inventory_management_system/presentation/screeens/reporsts/sales_report.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Reports',
              style: TextStyle(color: white),
            ),
          ),
          backgroundColor: blue,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white, 
            unselectedLabelColor: Colors
                .white70, 
            tabs: [
              Tab(
                icon: Icon(CupertinoIcons.chart_bar,
                    color: Colors.white), 
                text: 'Sales Report',
              ),
              Tab(
                icon: Icon(CupertinoIcons.graph_square, color: Colors.white),  // Set the icon color
                text: 'Items Report',
              ),
            ],
          ),
        ),
          body: const TabBarView(
            children: [
              SalesReportTab(), // Replace with your actual Sales Report widget
              ItemsReportTab(), // Replace with your actual Items Report widget
            ],
      ),
      )  );
  }
}


