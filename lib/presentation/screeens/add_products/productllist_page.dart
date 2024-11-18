import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/customer_details_model.dart';
import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/data/repository/customer_details/cusomer_data.dart';
import 'package:inventory_management_system/presentation/bloc/fetchproductlist/fetchproductlist_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/add_products.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/product_details_screen.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchProductListBloc>().add(FetchProductListInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: BlocBuilder<FetchProductListBloc, FetchProductListState>(
        builder: (context, state) {
          if (state is FetchProductListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchProductListSuccessState) {
            // Show the list of products using GridView.builder
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.64,
                crossAxisSpacing: 5,
                mainAxisSpacing: 10,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final Products product = state.products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(product: product),
                      ),
                    );
                  },
                  child: ProductCard(product: product),
                ); // Fix: Pass product directly
              },
            );
          } else if (state is FetchProductListErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () async {
          // Navigate to AddProducts and await the result
          final productAdded = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddProducts()),
          );

          // Check if a product was added (use true or a specific signal)
          if (productAdded == true) {
            // Trigger the event to fetch the updated product list
            context
                .read<FetchProductListBloc>()
                .add(FetchProductListInitialEvent());
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Products product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adjust the elevation for shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for product image
          Container(
            height: 200,
            width: 200,
            color: Colors.grey[300], // Placeholder color
            child: Image.network(
              product.imageUrl, // Ensure this is a valid URL
              fit: BoxFit.fill, // Adjust the image to fit within the container
              errorBuilder: (context, error, stackTrace) {
                // Handle the error case, e.g., by showing a placeholder image
                return Center(child: Text('Image failed to load'));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // If the image has loaded, show it
                }
                // Show a loading spinner while the image is loading
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          //  SizedBox(height: 10), // Adjusted spacing
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
            child: CustomText(
              text: product.productName,
              fontSize: 24, // Adjust font size as needed
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Use Colors.black instead of black
            ),
          ),
          SizedBox(height: 5), // Adjusted spacing
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
            child: Row(
              children: [
                CustomText(
                  text:
                      "Qty ${product.quantity.toInt().toString()}", // Assuming quantity is a property
                  fontSize: 20, // Adjust font size as needed
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey, // Use Colors.grey instead of grey
                ),
                Spacer(),
                CustomText(
                  text: "₹ ${product.price.toInt().toString()}",
                  fontSize: 20, // Adjust font size as needed
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Use Colors.green instead of green
                ),
                SizedBox(
                  width: .02.sw,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
