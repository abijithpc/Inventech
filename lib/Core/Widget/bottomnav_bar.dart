import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventech/Core/constant/constant.dart';
import 'package:inventech/Home_Screen/presentation/Widget/dashboard.dart';
import 'package:inventech/Home_Screen/presentation/page/home_screen.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_bloc.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_event.dart';
import 'package:inventech/Product_Page/presentation/pages/add_product_page.dart';
import 'package:inventech/Product_Page/presentation/pages/product_list_page.dart';

class BottomnavBar extends StatefulWidget {
  const BottomnavBar({super.key});

  @override
  State<BottomnavBar> createState() => _BottomnavBarState();
}

class _BottomnavBarState extends State<BottomnavBar> {
  int currentIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    ProductListPage(),
    AddProductPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      backgroundColor: kWhite,

      body: IndexedStack(
        index: currentIndex,
        children:
            pages.map((page) {
              if (page is DashBoard) {
                return DashBoard(size: size);
              } else {
                return page;
              }
            }).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          child: BottomNavigationBar(
            backgroundColor: kBlue,
            currentIndex: currentIndex,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            selectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(),
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() => currentIndex = index);
              if (index == 1) {
                Future.microtask(() {
                  context.read<ProductBloc>().add(LoadProductsEvent());
                });
              }
            },

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_outlined),
                activeIcon: Icon(Icons.dashboard),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                activeIcon: Icon(Icons.shopping_bag),
                label: 'Product',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                activeIcon: Icon(Icons.person),
                label: 'Add Product',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.person_outline),
              //   activeIcon: Icon(Icons.person),
              //   label: 'Profile',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
