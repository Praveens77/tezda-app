import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_homescreen/common/colors.dart';
import 'package:task_homescreen/common/widget.dart';
import 'package:task_homescreen/screen/list/model/model.dart';

class DetailView extends StatelessWidget {
  final Product? product;

  const DetailView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: white,
        title:
            CustomText("Product Detail", black, 20, "Poppins", FontWeight.bold),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: button,
                    width: 2.0,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product!.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomText(
                'Name: ${product!.title}',
                black,
                15,
                'Poppins',
                FontWeight.bold,
              ),
              const SizedBox(height: 20),
              ParagraphText("Description: ${product!.description}", black, 15,
                  'Poppins', FontWeight.w100, TextAlign.justify),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'Price: \$${product!.price}',
                    black,
                    15,
                    'Poppins',
                    FontWeight.normal,
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    'category: ${product!.category}',
                    black,
                    15,
                    'Poppins',
                    FontWeight.normal,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
