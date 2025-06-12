import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventech/Core/Widget/bottomnav_bar.dart';
import 'package:inventech/Core/Widget/textform_widget.dart';
import 'package:inventech/Core/constant/constant.dart';
import 'package:inventech/Product_Page/data/Model/product_model.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_bloc.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_event.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductPage extends StatefulWidget {
  final ProductModel? products;
  const AddProductPage({super.key, this.products});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    await [Permission.storage, Permission.photos].request();

    if (await Permission.photos.isGranted ||
        await Permission.storage.isGranted) {
      final List<XFile>? selectedImages = await _picker.pickMultiImage();
      if (selectedImages != null && selectedImages.isNotEmpty) {
        setState(() {
          _images.addAll(selectedImages);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied to access gallery')),
      );
    }
  }

  void submitProduct() {
    final isEdit = widget.products != null;
    if (!_formKey.currentState!.validate() || (!isEdit && _images.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields and select images'),
        ),
      );
      return;
    }

    final product = ProductModel(
      id: widget.products?.id,
      name: nameController.text.trim(),
      brand: brandController.text.trim(),
      model: modelController.text.trim(),
      description: descriptionController.text.trim(),
      images: _images.map((file) => file.path).toList(),
      createdAt: DateTime.now(),
    );

    if (widget.products == null) {
      context.read<ProductBloc>().add(AddProductEvent(product));
    } else {
      context.read<ProductBloc>().add(UpdateProductEvent(product));
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BottomnavBar()),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Product updated successfully!',
          style: TextStyle(color: Colors.green),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.products != null) {
      nameController.text = widget.products!.name;
      brandController.text = widget.products!.brand;
      modelController.text = widget.products!.model;
      descriptionController.text = widget.products!.description;
      for (final path in widget.products!.images) {
        _images.add(XFile(path));
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isEdit = widget.products != null;

    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Product' : 'Add Product',
          style: TextStyle(color: kBlack),
        ),
        backgroundColor: kWhite,
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: kBlack),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      constraints.maxWidth > 600 ? 600 : constraints.maxWidth,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pick Image Button
                      SizedBox(
                        width: double.infinity,
                        height: 150,
                        child: ElevatedButton.icon(
                          onPressed: pickImages,
                          icon: Icon(Icons.add_a_photo, color: kWhite),
                          label: Text('Pick Images', style: whiteTextStyle),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Show Picked Images
                      if (_images.isNotEmpty)
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    File(_images[index].path),
                                    width: size.width > 600 ? 120 : 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (_, __, ___) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      const SizedBox(height: 20),

                      // Name
                      customTextFormField(
                        colors: Colors.grey.shade100,
                        controller: nameController,
                        hintText: 'Name',
                        prefixIcon: Icons.title,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter product name'
                                    : null,
                      ),
                      const SizedBox(height: 16),

                      // Brand
                      customTextFormField(
                        colors: Colors.grey.shade100,
                        controller: brandController,
                        hintText: 'Brand',
                        prefixIcon: Icons.branding_watermark,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter brand name'
                                    : null,
                      ),
                      const SizedBox(height: 16),

                      // Model
                      customTextFormField(
                        textInputType: TextInputType.number,
                        colors: Colors.grey.shade100,
                        controller: modelController,
                        hintText: 'Model',
                        prefixIcon: Icons.numbers,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter model'
                                    : null,
                      ),
                      const SizedBox(height: 16),

                      // Description
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 8,
                        minLines: 5,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          hintText: 'Description',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Enter description'
                                    : null,
                      ),
                      const SizedBox(height: 30),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: submitProduct,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            isEdit ? 'Update Product' : 'Submit',
                            style: whiteTextStyle.copyWith(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
