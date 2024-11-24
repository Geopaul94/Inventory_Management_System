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
        centerTitle: true,
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
                  decoration: BoxDecoration(
                    color: blue,
                    border: Border.all(
                      color: lightgrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
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
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return EditCategory(editcategory: widget.category);
                          },
                        ));
                      }),
                )),
          ),
        ],
        backgroundColor: blue,
      ),
      body: BlocBuilder<FetchProductListBloc, FetchProductListState>(
        builder: (context, state) {
          if (state is FetchProductListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchProductListSuccessState) {
            if (state.products.isEmpty) {
              return const Center(
                child: Text("No Products Available"),
              );
            }

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
                );
              },
            );
          } else if (state is FetchProductListErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(vertical: .04.sh, horizontal: .01.sw),
        child: FloatingActionButton.extended(
          backgroundColor: floatingActionButtoncolor,
          foregroundColor: white,
          onPressed: () async {
            final productAdded = await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddProducts(
                      productCategory:
                          widget.category.productCategory.toString())),
            );

            if (productAdded == true) {
              context
                  .read<FetchProductListBloc>()
                  .add(FetchProductListInitialEvent());
            }
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Product'),
        ),
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
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 200,
            color: Colors.grey[300],
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('Image failed to load'));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          //  SizedBox(height: 10), //
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
            child: CustomText(
              text: product.productName,
              fontSize: 24,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 0, 0),
            child: Row(
              children: [
                CustomText(
                  text: "Qty ${product.quantity.toInt().toString()}",
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
                const Spacer(),
                CustomText(
                    text: "₹ ${product.price.toInt().toString()}",
                    fontSize: 20, 
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: green),
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
