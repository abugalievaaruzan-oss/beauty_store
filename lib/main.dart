import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';

void main() {
  runApp(const BeautyStoreApp());
}

class BeautyStoreApp extends StatelessWidget {
  const BeautyStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty Store',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
        ),
        useMaterial3: true,
      ),
      home: const CatalogScreen(),
    );
  }
}