import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_homescreen/common/colors.dart';
import 'package:task_homescreen/common/widget.dart';
import 'package:task_homescreen/screen/detail/view/detail_view.dart';
import 'package:task_homescreen/screen/favourate/controller/fav_controller.dart';
import 'package:task_homescreen/screen/favourate/view/fav_view.dart';
import 'package:task_homescreen/screen/list/controller/list_controller.dart';
import 'package:task_homescreen/screen/profile/view/prof_view.dart';

// ignore: must_be_immutable
class ListPage extends StatelessWidget {
  final ListController controller = Get.put(ListController());
  final FavourateController favourateController =
      Get.put(FavourateController());
  int selectedIndex = 0;
  ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title: CustomText("DashBoard", black, 20, "Poppins", FontWeight.bold),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              color: black,
              onPressed: () {
                Get.to(() => FavourateView());
              },
              icon: const Icon(Icons.favorite_outline, size: 30),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              color: black,
              onPressed: () {
                Get.to(() => ProfileScreen());
              },
              icon: const Icon(Icons.person_outline_outlined, size: 30),
            ),
            label: '',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: FutureBuilder(
          future: controller.fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Column(
                children: [
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.products.length,
                        itemExtent:
                            170, // Set the item extent including the space
                        itemBuilder: (context, index) {
                          final product = controller.products[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.to(() => DetailView(
                                          product: product,
                                        ));
                                  },
                                  child: Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black54),
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            children: [
                                              const SizedBox(height: 15),
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black54),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    product.image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(width: 20),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                // ignore: unnecessary_string_interpolations
                                                "${_truncateString(product.title, 20)}", // 20 is the maximum number of characters
                                                black,
                                                15,
                                                "family",
                                                FontWeight.bold,
                                              ),
                                              const SizedBox(height: 5),
                                              CustomText(
                                                "Price: \$${product.price}",
                                                black,
                                                12,
                                                "Poppins",
                                                FontWeight.normal,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: CircleAvatar(
                                    backgroundColor: button,
                                    radius: 20,
                                    child: IconButton(
                                      icon: Icon(
                                        (product.isFavorite == true)
                                            ? Icons.favorite_outline
                                            : Icons.favorite_outline,
                                        color: (product.isFavorite == true)
                                            ? white
                                            : white,
                                      ),
                                      onPressed: () {
                                        Get.snackbar("Added to Favourites", "This item is added to your favourites successfully.");
                                        if (!product.isFavorite) {
                                          // Toggle the favorite status on single tap
                                          controller
                                              .toggleFavoriteStatus(product.id);

                                          // Add to favorites only if not already in the list
                                          if (!favourateController
                                              .favoriteProducts
                                              .contains(product)) {
                                            favourateController
                                                .addToFavorites(product);
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _truncateString(String inputString, int maxLength) {
    if (inputString.length <= maxLength) {
      return inputString;
    } else {
      return '${inputString.substring(0, maxLength)}...';
    }
  }
}
