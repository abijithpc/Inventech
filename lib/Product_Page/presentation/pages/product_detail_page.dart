import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:inventech/Core/constant/constant.dart';
import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:inventech/Product_Page/presentation/pages/add_product_page.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final validImages =
        product.images.where((path) => File(path).existsSync()).toList();

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(product.name),
        centerTitle: true,
        backgroundColor: kWhite,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            if (validImages.isNotEmpty)
              CarouselSlider(
                items:
                    validImages.map((path) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          File(path),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                options: CarouselOptions(
                  height: 250,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  autoPlay: true,
                ),
              ),
            const SizedBox(height: 16),

            // Product Name
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProductPage(products: product),
                      ),
                    );
                  },
                  icon: Icon(Icons.edit),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Brand
            Text(
              "Brand: ${product.brand}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 8),
            Text(
              "Model: ${product.model}",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            // Price
            const SizedBox(height: 16),

            // Description
            Text(
              "Description:",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
