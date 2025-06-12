import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_bloc.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_event.dart';
import 'package:inventech/Product_Page/presentation/pages/product_detail_page.dart';
import 'package:inventech/Product_Page/presentation/widget/delete_dialog.dart';

class ProductCard extends StatelessWidget {
  List<ProductModel> products;
  ProductCard({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          final imagePath =
              product.images.isNotEmpty ? product.images.first : null;

          return GestureDetector(
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(product: product),
                  ),
                ),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child:
                        imagePath != null && File(imagePath).existsSync()
                            ? Image.file(
                              File(imagePath),
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                            : Container(
                              height: 120,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 40,
                              ),
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      product.brand,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final confirmed = await showDeleteConfirmationDialog(
                        context,
                      );
                      if (confirmed && product.id != null) {
                        context.read<ProductBloc>().add(
                          DeleteProductEvent(product.id!),
                        );
                      } else {
                        debugPrint(
                          "⚠️ Product ID is null or deletion not confirmed",
                        );
                      }
                    },
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
