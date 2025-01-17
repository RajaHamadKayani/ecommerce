import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:ecommerce_app/controllers/product_controller.dart';
import 'package:ecommerce_app/views/widgets/add_product_drop_down_widget.dart';
import 'package:ecommerce_app/views/widgets/resuable_text_form_field_1.dart';
import 'package:ecommerce_app/views/widgets/reusable_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  XFile? _image; // Holds the picked image

  // Track boolean dropdown values
  bool isTopProduct = false;
  bool isNewItem = false;
  bool isFlashSale = false;
  bool isMostPopular = false;

  double? offPercentage; // Discount percentage for flash sale

  ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/forget_password_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      "Add Product",
                      style: GoogleFonts.raleway(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        _showImageSourceBottomSheet(context);
                      },
                      child: _image == null
                          ? DottedBorder(
                              borderType: BorderType
                                  .Circle, // Use Circle for circular borders
                              dashPattern: const [15, 3],
                              color: const Color(0xff004CFF),
                              strokeWidth: 1.5,
                              child: Container(
                                height:
                                    90, // Ensure height and width are the same for a perfect circle
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  shape: BoxShape.circle, // Circle shape
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 26),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: 28,
                                          width: 34,
                                          child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Color(0xff004CFF),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.color ==
                                              Colors.white
                                          ? const Color(0xff575075)
                                          : Colors.white,
                                      width: 3,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundImage:
                                        FileImage(File(_image!.path)),
                                    onBackgroundImageError:
                                        (error, stackTrace) {
                                      print("Failed to load image: $error");
                                    },
                                    child: null,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showImageSourceBottomSheet(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ResuableTextFormField1(
                        controller: productController.nameController,
                        hintText: "Enter Product Name",
                        title: "Product Name"),
                    ResuableTextFormField1(
                        controller: productController.descriptionController,
                        hintText: "Enter Product Description",
                        title: "Product Description"),
                    ResuableTextFormField1(
                        controller: productController.priceController,
                        hintText: "Enter Product Price",
                        title: "Product Price"),
                    ResuableTextFormField1(
                        controller: productController.stockController,
                        hintText: "Enter Product Stock",
                        title: "Product Stock"),
                    ResuableTextFormField1(
                        controller: productController.categoryController,
                        hintText: "Enter Product Category",
                        title: "Product Category"),
                          // Dropdowns
                      AddProductDropDownWidget(
                        title: "Is Top Product",
                        value: isTopProduct,
                        onChanged: (value) => setState(() {
                          isTopProduct = value;
                        }),
                      ),
                      AddProductDropDownWidget(
                        title: "Is New Item",
                        value: isNewItem,
                        onChanged: (value) => setState(() {
                          isNewItem = value;
                        }),
                      ),
                      AddProductDropDownWidget(
                        title: "Is Flash Sale",
                        value: isFlashSale,
                        onChanged: (value) => setState(() {
                          isFlashSale = value;
                          if (!isFlashSale) offPercentage = null;
                        }),
                      ),
                      if (isFlashSale)
                        ResuableTextFormField1(
                          controller:productController.flashSaleController ,
                          hintText: "Enter Off Percentage",
                          title: "Off Percentage",

                        ),
                      AddProductDropDownWidget(
                        title: "Is Most Popular",
                        value: isMostPopular,
                        onChanged: (value) => setState(() {
                          isMostPopular = value;
                        }),
                      ),
                    const SizedBox(height: 20),
                    Center(
                      child: Obx(
                        () => productController.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : GestureDetector(
                                onTap: () async {
                                  await productController.addProduct(
                                      _image != null ? File(_image!.path) : null,
                                      isTopProduct,
                                      isNewItem,
                                      isFlashSale,
                                      isMostPopular,
                                      productController.flashSaleController.text,
                                    );
                                  productController.nameController.clear();
                                  productController.descriptionController
                                      .clear();
                                  productController.priceController.clear();
                                  productController.stockController.clear();
                                  productController.categoryController.clear();
                                },
                                child: ReusableContainer(
                                    borderRadius: BorderRadius.circular(16),
                                    color: 0xff004CFF,
                                    title: "Done"),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent, // Make the background transparent
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be full screen
      builder: (context) {
        return Stack(
          children: [
            // Semi-transparent background overlay
            GestureDetector(
              onTap: () => Navigator.pop(
                  context), // Close the sheet when background is tapped
              child: Container(
                color: Colors.black
                    .withOpacity(0.5), // Semi-transparent background
              ),
            ),
            Align(
              alignment:
                  Alignment.bottomCenter, // Align the content at the bottom
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.bodyLarge?.color ==
                            Colors.white
                        ? const Color(0xff100C26)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                        color: Colors.transparent), // Transparent side borders
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize
                            .min, // Adjust the height based on content
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: SizedBox(
                              height: 72,
                              width: 72,
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color(0xff004CFF),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "Choose from gallery or",
                            style: TextStyle(
                              color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color ==
                                      Colors.white
                                  ? Colors.white
                                  : const Color(0xff0C091C),
                              fontFamily: "Pulp",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "click with camera",
                            style: TextStyle(
                              color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color ==
                                      Colors.white
                                  ? Colors.white
                                  : const Color(0xff0C091C),
                              fontFamily: "Pulp",
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Choose a photo that represents you.",
                            style: TextStyle(
                              color: const Color(0xff948FAD),
                              fontFamily: "Pulp",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "Upload from gallery or take a picture",
                            style: TextStyle(
                              color: const Color(0xff948FAD),
                              fontFamily: "Pulp",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "instantly!",
                            style: TextStyle(
                              color: const Color(0xff948FAD),
                              fontFamily: "Pulp",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                      try {
                                        final XFile? image =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                        );
                                        if (image != null) {
                                          setState(() {
                                            _image = image;
                                          });
                                        }
                                      } catch (e) {
                                        print(
                                            "Error picking image from gallery: $e");
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.color ==
                                                Colors.white
                                            ? Colors.white.withOpacity(0.06)
                                            : const Color(0xff0C091C),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 19),
                                        child: Center(
                                          child: Text(
                                            "Choose from gallery",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Pulp",
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.pop(
                                          context); // Close the bottom sheet
                                      try {
                                        final XFile? image =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.camera,
                                        );
                                        if (image != null) {
                                          setState(() {
                                            _image = image;
                                          });
                                        }
                                      } catch (e) {
                                        print(
                                            "Error picking image from camera: $e");
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color(0xff5858CC),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 19),
                                        child: Center(
                                          child: Text(
                                            "Click From Camera",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Pulp",
                                              color: const Color(0xffffffff),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
            ),
          ],
        );
      },
    );
  }
}
