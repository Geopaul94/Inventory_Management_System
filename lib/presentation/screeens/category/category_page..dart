import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inventory_management_system/data/models/catergorey/category_model.dart';
import 'package:inventory_management_system/presentation/bloc/category/category_bloc.dart';
import 'package:inventory_management_system/presentation/screeens/add_products/productllist_page.dart';
import 'package:inventory_management_system/presentation/screeens/category/add_category%20.dart';
import 'package:inventory_management_system/presentation/screeens/profile_page.dart';
import 'package:inventory_management_system/presentation/widgets/CustomElevatedButton.dart';
import 'package:inventory_management_system/presentation/widgets/CustomText.dart';
import 'package:inventory_management_system/presentation/widgets/shimmer_loading.dart';
import 'package:inventory_management_system/utilities/constants/constants.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(.065.sh),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Category",
            style: TextStyle(
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
                child: CircleAvatar(
                  backgroundImage: const NetworkImage(
                    'https://res.cloudinary.com/duyqxp4er/image/upload/v1731928002/vifrvccl1prd2uzetj2k.jpg', // Replace with your avatar URL
                  ),
                  radius: 15, // Adjust the radius as needed
                  // Add a white border
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white70, // Border color
                        width: 1.0, // Border width
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
              final List<CategoryModel> categoryModel = state.categoryModel;

              return ListView.builder(
                itemCount: state.categoryModel.length,
                itemBuilder: (context, index) {
                  final category = state.categoryModel[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(
                            category: categoryModel[index],
                          ),
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
              builder: (context) => const AddCategoryPage(),
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

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                h10,
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  height: 0.350.sh,
                  width: .600.sw,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      category.categoryImage.toString(),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                            child: Text('Image failed to load'));
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }

                        return const Center(child: ShimmerLoading());
                      },
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 3, 0, 0),
                      child: CustomText(
                        text: category.productCategory.toString(),
                        fontSize: 24,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                    ),
                    h10,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: '''  Purchased 
      Quantity   :  ''',
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: black,
                        ),
                        CustomText(
                          text: '412',
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: black,
                        ),
                      ],
                    ),
                    h10,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "  Sold : ",
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: black,
                        ),
                        CustomText(
                          text: '          : 235',
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: black,
                        ),
                      ],
                    ),
                    h5,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: "  Balance : ",
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: black,
                        ),
                        CustomText(
                          text: '    : 120',
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: black,
                        ),
                      ],
                    ),
                    // CustomElevatedButton(
                    //     text: "Reports",
                    //     height: 00.07.sh,
                    //     width: 0.3.sw,
                    //     color: blue,
                    //     fontSize: 18.sp,
                    //     fontWeight: FontWeight.normal,
                    //     paddingHorizontal: 0.01.sh,
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) =>
                    //               MainScreens(initialIndex: 3),
                    //         ),
                    //       );
                    //     })
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
