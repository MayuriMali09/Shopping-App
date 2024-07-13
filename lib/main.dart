import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/cart_provider.dart';
import 'package:shoppingapp/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shoppingapp/globalvariables.dart';
import 'Details_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CartProvider(),
      child: MaterialApp(
        title: 'Shopping App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightBlue,
               primary: Colors.lightBlue),
          inputDecorationTheme:const InputDecorationTheme(//this will be default for all my input decoration
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            prefixIconColor: Colors.black,
          ),
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),//title large is by default taken by appbar
            titleMedium:TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            bodyMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          appBarTheme:const AppBarTheme(
            titleTextStyle: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          useMaterial3: true,
        ),
      
        home:const HomePage(),
      ),
    );
  }
}
