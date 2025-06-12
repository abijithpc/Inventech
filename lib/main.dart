import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventech/Login_page/presentation/Bloc/login_bloc.dart';
import 'package:inventech/Product_Page/presentation/Bloc/product_bloc.dart';
import 'package:inventech/Splash_Screen/presentation/Bloc/splash_bloc.dart';
import 'package:inventech/Splash_Screen/presentation/pages/splash_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'Core/DI/di.dart' as di;
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'user.db');
  await deleteDatabase(path);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(create: (_) => di.sl<SplashBloc>()),
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => di.sl<ProductBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventech',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 4, 4, 46),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
