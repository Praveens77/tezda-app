import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_homescreen/common/colors.dart';
import 'package:task_homescreen/common/image.dart';
import 'package:task_homescreen/common/widget.dart';
import 'package:task_homescreen/screen/detail/view/detail_view.dart';
import 'package:task_homescreen/screen/favourate/controller/fav_controller.dart';

// ignore: must_be_immutable
class FavourateView extends StatelessWidget {
  FavourateController controller = Get.put(FavourateController());

  FavourateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: CustomText("Favourite", black, 20, "Poppins", FontWeight.bold),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.favoriteProducts.isEmpty
            ? Center(
                child: Image.asset(
                  ImagePath.empty,
                  height: 150,
                  width: 150,
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomText(
                          "Swipe left or right to remove from favorites...",
                          Colors.black54,
                          14,
                          "family",
                          FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.favoriteProducts.length,
                        itemBuilder: (context, index) {
                          final product = controller.favoriteProducts[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Dismissible(
                              key: Key(product.id.toString()),
                              onDismissed: (direction) {
                                controller.removeFromFavorites(product.id);
                              },
                              background: Container(
                                color: button,
                                alignment: AlignmentDirectional.centerEnd,
                                child: const Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.delete,
                                    color: white,
                                  ),
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => DetailView(product: product));
                                },
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 120,
                                          width: 120,
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
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                truncateString(
                                                    product.title, 20),
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  String truncateString(String inputString, int maxLength) {
    if (inputString.length <= maxLength) {
      return inputString;
    } else {
      return '${inputString.substring(0, maxLength)}...';
    }
  }
}
