import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';
import 'package:inventory_management_system/data/models/product_model.dart';
import 'package:inventory_management_system/presentation/bloc/fetchproductlist/fetchproductlist_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/addpost_page/add_products.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/product_details_screen.dart';
import 'package:inventory_management_system/presentation/screeens/category/edit_category.dart';
import 'package:inventory_management_system/presentation/screeens/profile_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class ProductPage extends StatefulWidget {
  final CategoryModel category;

  const ProductPage({super.key, required this.category});
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
        automaticallyImplyLeading: false,
        title: Text(
          widget.category.productCategory.toString(),
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.normal, color: white),
        ),
        centerTitle: true, // Center the title
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()),
                  );
                },
                child: Container(
                  // Set the height of the container

                  decoration: BoxDecoration(
                    color: Colors.blue, // Background color of the container

                    border: Border.all(
                      color: lightgrey, // Border color

                      width: 2.0, // Border thickness
                    ),

                    borderRadius:
                        BorderRadius.circular(8.0), // Optional: rounded corners
                  ),

                  child: CustomElevatedButton(
                      text: "Edit",
                      width: 0.15.sw,
                      height: 0.04.sh,
                      fontSize: 14.sp,
                      paddingHorizontal: .03.sw,
                      paddingVertical: 0.0002.sh,
                      color: blue,
                      borderRadius: 2,
                      textColor: white,
                      onPressed: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return EditCategory(editcategory: widget.category);
                        },));
                      }),
                )),
          ),
        ],
        backgroundColor: Colors.blue, // Change the background color as needed
      ),

      //CustomAppBar(title: widget.category.productCategory.toString()),
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
                        builder: (context) => ProductDetailsScreen(
                          product: product,
                        ),
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
        backgroundColor: floatingActionButtoncolor,
        foregroundColor: white,
        onPressed: () async {
          // Navigate to AddProducts and await the result
          final productAdded = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => AddProducts(
                    productCategory:
                        widget.category.productCategory.toString())),
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

  const ProductCard({super.key, required this.product});

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
                return const Center(child: Text('Image failed to load'));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // If the image has loaded, show it
                }
                // Show a loading spinner while the image is loading
                return const Center(child: CircularProgressIndicator());
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
          const SizedBox(height: 5), // Adjusted spacing
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
                const Spacer(),
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
