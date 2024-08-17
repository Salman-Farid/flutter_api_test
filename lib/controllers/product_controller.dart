import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';
import 'image_controller.dart';
import 'user_controller.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  final ImageController imageController = Get.put(ImageController());
  final UserController userController =
      Get.find<UserController>(); // Access the controller

  // Controllers for product details
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _slugController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _videoController = TextEditingController();

  var isLoading = false.obs;
  var productList = <Data>[].obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  // Getters for the controllers
  TextEditingController get nameController => _nameController;
  TextEditingController get slugController => _slugController;
  TextEditingController get priceController => _priceController;
  TextEditingController get quantityController => _quantityController;
  TextEditingController get summaryController => _summaryController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get categoryController => _categoryController;
  TextEditingController get brandController => _brandController;
  TextEditingController get sizeController => _sizeController;
  TextEditingController get videoController => _videoController;

  // Getter for products
  //List<Product> get products => _products.toList();
  List<Data> get products => productList;

  // Add method to pick additional images
  Future<void> pickAdditionalImages() async {
    await imageController.pickAdditionalImages();
  }

  bool validate() {
    final name = nameController.text.trim();
    final price = priceController.text.trim();
    final quantity = quantityController.text.trim();
    final coverPhoto = imageController.imageBase64;
    final additionalImages = imageController.additionalImagesBase64;

    // Validate that all required fields are filled
    if (name.isEmpty ||
        price.isEmpty ||
        quantity.isEmpty ||
        coverPhoto.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please fill all required fields and upload a cover photo.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Validate price and quantity as numbers
    if (double.tryParse(price) == null) {
      Get.snackbar(
        'Validation Error',
        'Price must be a valid number.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (int.tryParse(quantity) == null) {
      Get.snackbar(
        'Validation Error',
        'Quantity must be a valid number.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    // Validate additional images if required
    if (additionalImages.isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please upload at least one additional image.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  // Create product
  Future<void> createProduct(
      Function(Product?, {String? errorMessage})? onCreate) async {
    final valid = validate();
    final user = userController.user.value;

    if (valid) {
      final product = Data(
        user: user!.id,
        coverPhoto: imageController.imageBase64,
        video: videoController.text,
        name: nameController.text,
        slug: slugController.text,
        price: int.tryParse(priceController.text) ?? 0,
        quantity: int.tryParse(quantityController.text) ?? 0,
        summary: summaryController.text,
        description: descriptionController.text,
        category: categoryController.text,
        brand: brandController.text,
        size: sizeController.text,
        images: imageController.additionalImagesBase64,
      );

      try {
        isLoading.value = true;
        final createdProduct = await _productService.createProduct(product.toJson());
        print('The created product from controller: $createdProduct');
        isLoading.value = false;
        if (onCreate != null){
          print('The created product from controller: $createdProduct');
          onCreate(createdProduct);
        }
      } catch (e) {
        isLoading.value = false;
        if (onCreate != null) onCreate(null, errorMessage: e.toString());
      }
    }
  }

  // Fetch all products
  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final productResponse = await _productService.getProducts();
      isLoading.value = false;
      if (productResponse != null && productResponse.data != null) {
        productList.assignAll(productResponse.data!);
      } else {
        productList.clear();
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch products: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Fetch product by ID

  Future<void> getProductById(
      String id, Function(Product, {String? errorMessage})?) async {
    try {
      isLoading.value = true;
      final productResponse = await _productService.getProductById(id);
      isLoading.value = false;
      if (productResponse != null && productResponse.data != null) {
        productList.assignAll(productResponse.data!);
      } else {
        productList.clear();
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch products: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

//
// Future<void> getProductById(String id, Function(Product?, {String? errorMessage})? onFetch) async {
//   try {
//     isLoading.value = true;
//     final productResponse = await _productService.getProductById(id);
//     isLoading.value = false;
//     if (productResponse != null) {
//       final product = productResponse.first;  // Assuming the first product is the one we're interested in
//       if (onFetch != null) onFetch(product);
//     }
//   } catch (e) {
//     isLoading.value = false;
//     if (onFetch != null) onFetch(null, errorMessage: e.toString());
//   }
// }

// Update product
  Future<void> updateProductById(String id, Product product,
      Function(Product?, {String? errorMessage})? onUpdate) async {
    try {
      isLoading.value = true;
      final updatedProductResponse =
          await _productService.updateProductById(id, product.toJson());
      isLoading.value = false;
      final updatedProduct =
          Product.fromJson(updatedProductResponse as Map<String, dynamic>);
      if (onUpdate != null) onUpdate(updatedProduct);
    } catch (e) {
      isLoading.value = false;
      if (onUpdate != null) onUpdate(null, errorMessage: e.toString());
    }
  }

// Delete product
  Future<void> deleteProduct(
      String id, Function(bool, {String? errorMessage})? onDelete) async {
    try {
      isLoading.value = true;
      final success = await _productService.deleteProductById(id);
      isLoading.value = false;
      if (onDelete != null) onDelete(success);
    } catch (e) {
      isLoading.value = false;
      if (onDelete != null) onDelete(false, errorMessage: e.toString());
    }
  }
}
