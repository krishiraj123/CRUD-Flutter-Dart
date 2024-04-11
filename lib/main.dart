import 'package:databaseapi/components/api_components/displayapi_screen.dart';
import 'package:databaseapi/components/database_components/display_screen.dart';
import 'package:databaseapi/components/equal_part_screen.dart';
import 'package:databaseapi/components/stack_demo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "CRUD DEMO",
      debugShowCheckedModeBanner: false,
      home: EqualPartPage(),
    );
  }
}