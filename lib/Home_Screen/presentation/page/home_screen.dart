import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventech/Core/constant.dart';
import 'package:inventech/Home_Screen/presentation/Widget/dashboard.dart';
import 'package:inventech/Home_Screen/presentation/Widget/showcupertinodialog.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_bloc.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_event.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_state.dart';
import 'package:inventech/Login_page/presentation/Pages/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoggedOut) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: kWhite,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            'InvenTech',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: Colors.black,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          backgroundColor: kWhite,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                showLogoutDialog(context, () {
                  context.read<AuthBloc>().add(LogoutRequested());
                }, 'Are you sure you want to logout?');
              },
              icon: const Icon(Icons.logout),
              color: Colors.redAccent,
            ),
          ],
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: ClipOval(
              child: Image.asset('assets/Inven.png', fit: BoxFit.cover),
            ),
          ),
        ),
        body: SingleChildScrollView(child: DashBoard(size: size)),
      ),
    );
  }
}
