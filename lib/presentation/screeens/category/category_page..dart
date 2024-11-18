import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';
import 'package:inventory_management_system/presentation/bloc/category/category_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/category/add_category%20.dart';
import 'package:inventory_management_system/presentation/screeens/category/subcategorypage.dart';
import 'package:inventory_management_system/presentation/screeens/profile_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/CustomeAppbar.dart';
import 'package:inventory_management_system/presentation/widgets/shimmer_loading.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(OnFetchAllCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize( preferredSize: Size.fromHeight(.065.sh), 
      
       child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Category",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true, // Center the title
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://res.cloudinary.com/duyqxp4er/image/upload/v1731928002/vifrvccl1prd2uzetj2k.jpg', // Replace with your avatar URL
                    ),
                    radius: 15, // Adjust the radius as needed
                    // Add a white border
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white70, // Border color
                          width:1.0, // Border width
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: Colors.blue, // Change the background color as needed
          ),
      ),

      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is AddCategoryErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error adding category. Please try again.'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FetchAllCategoryLoadingState) {
            return const Center(child: ShimmerLoading());
          } else if (state is FetchAllCategoryErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error fetching categories. Please try again.'),
                  const SizedBox(height: 16),
                  CustomElevatedButton(
                    text: "Retry",
                    onPressed: () {
                      context
                          .read<CategoryBloc>()
                          .add(OnFetchAllCategoryEvent());
                    },
                  ),
                ],
              ),
            );
          } else if (state is FetchAllCategoryInitialState) {
            if (state.categoryModel.isEmpty) {
              return const Center(child: Text("No Categories Available"));
            } else {
              return ListView.builder(
                itemCount: state.categoryModel.length,
                itemBuilder: (context, index) {
                  final category = state.categoryModel[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Subcategorypage(),
                        ),
                      );
                    },
                    child: CategoryCard(category: category),
                  );
                },
              );
            }
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: floatingActionButtoncolor,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCategoryPage(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Category'),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

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
              category.categoryImage.toString(), // Ensure this is a valid URL
              fit: BoxFit.fill, // Adjust the image to fit within the container
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Text('Image failed to load'));
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child; // If the image has loaded, show it
                }

                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          //  SizedBox(height: 10), // Adjusted spacing
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
            child: CustomText(
              text: category.productCategory.toString(),
              fontSize: 24, // Adjust font size as needed
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black, // Use Colors.black instead of black
            ),
          ),
          const SizedBox(height: 5), // Adjusted spacing
        ],
      ),
    );
  }
}
