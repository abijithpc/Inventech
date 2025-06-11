import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Core/Widget/bottomnav_bar.dart';
import 'package:inventech/Core/constant.dart';
import 'package:inventech/Core/textform_widget.dart';
import 'package:inventech/Home_Screen/presentation/page/home_screen.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_bloc.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_event.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_state.dart'; // make sure this exists

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kWhite,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const BottomnavBar()),
                  );
                } else if (state is AuthFailure) {
                  showDialog(
                    context: context,
                    builder:
                        (_) => AlertDialog(
                          title: const Text('Login Failed'),
                          content: Text(state.message),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                  );
                }
              },
              child: Login_Widget(size, context),
            ),
          ),
        ),
      ),
    );
  }

  Form Login_Widget(Size size, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width * 0.5,
            height: size.width * 0.5,
            child: Image.asset('assets/Inven.png'),
          ),
          SizedBox(height: size.height * 0.10),
          Text(
            'Sign In',
            style: TextStyle(
              color: kBlack,
              fontSize: size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Please sign in to continue to your account',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: size.width * 0.04,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.02),

          /// Email Field
          customTextFormField(
            controller: _emailController,
            hintText: 'Email Id',
            prefixIcon: Icons.lock,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.02),

          /// Password Field
          customTextFormField(
            controller: _passwordController,
            hintText: 'Password',
            prefixIcon: Icons.lock,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          SizedBox(height: size.height * 0.04),

          /// Login Button
          SizedBox(
            width: double.infinity,
            height: size.height * 0.07,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kBlue),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final email = _emailController.text.trim();
                  final password = _passwordController.text.trim();

                  context.read<AuthBloc>().add(
                    LoginButtonPressed(email: email, password: password),
                  );
                }
              },
              child: Text('Login', style: whiteTextStyle),
            ),
          ),
        ],
      ),
    );
  }
}
