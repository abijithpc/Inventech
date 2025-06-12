import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Core/Widget/bottomnav_bar.dart';
import 'package:inventech/Core/constant/constant.dart';
import 'package:inventech/Login_page/presentation/Pages/login_screen.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_bloc.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_event.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(StartSplashAnimation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlue,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is NavigateToHome) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BottomnavBar()),
            );
          } else if (state is NavigateToLogin) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            double opacity = 0.0;
            if (state is SplashAnimated) {
              opacity = 1.0;
            }
            return Center(
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: SizedBox(
                  width: 220,
                  height: 220,
                  child: Image.asset(
                    'assets/Inven-removebg-preview.png',
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        'Image not found',
                        style: TextStyle(color: Colors.white),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
