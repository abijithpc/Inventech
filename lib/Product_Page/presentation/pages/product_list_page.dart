import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Core/constant/constant.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_bloc.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_event.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_state.dart';
import 'package:inventech/Product_Page/presentation/widget/product_card.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: const Text('Product List'),
        centerTitle: true,
        backgroundColor: kWhite,
        actions: [
          TextButton(
            onPressed: () async {
              context.read<ProductBloc>().add(LoadProductsEvent());
            },
            child: Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            if (state.products.isEmpty) {
              return const Center(child: Text('No products found.'));
            }

            return ProductCard(products: state.products);
          } else if (state is ProductFailure) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
