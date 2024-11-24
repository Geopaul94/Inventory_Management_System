import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_bloc.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_event.dart';
import 'package:inventory_management_system/presentation/bloc/searchuser/searchuser_state.dart';


class CustomerSearchPage extends StatefulWidget {
  @override
  _CustomerSearchPageState createState() => _CustomerSearchPageState();
}

class _CustomerSearchPageState extends State<CustomerSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      // Dispatch a search event whenever the text changes
      context.read<CustomerSearchBloc>().add(SearchCustomerByNameEvent(_searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding for better spacing
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Enter customer name',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear(); // Clear search input
                    context.read<CustomerSearchBloc>().add(SearchCustomerByNameEvent('')); // Reset search
                  },
                ),
              ),
            ),
            SizedBox(height: 16), // Space between text field and results
            Expanded(
              child: BlocBuilder<CustomerSearchBloc, CustomerSearchState>(
                builder: (context, state) {
                  if (state is CustomerSearchLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is CustomerSearchSuccessState) {
                    final customers = state.customers;
                    return ListView.builder(
                      itemCount: customers.length,
                      itemBuilder: (context, index) {
                        var customer = customers[index];
                        return ListTile(
                          title: Text(customer['customerName']),
                          subtitle: Text(customer['phoneNumber']),
                          onTap: () {
                            // Handle tap to show customer details or navigate to another page
                          },
                        );
                      },
                    );
                  } else if (state is CustomerSearchErrorState) {
                    return Center(child: Text('Error: ${state.error}'));
                  }
                  return Center(child: Text('No results found.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose(); // Dispose of the controller when done
    super.dispose();
  }
}
