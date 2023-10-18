import 'dart:convert';
import 'package:apihandling/getapi.dart/api_to_dropdown.dart';
import 'package:apihandling/getapi.dart/home.dart';
import 'package:apihandling/getapi.dart/practice2.dart';
import 'package:apihandling/getapi.dart/productapi.dart';
import 'package:apihandling/getapi.dart/user_practice3.dart';
import 'package:apihandling/postapi.dart/signin.dart';
import 'package:apihandling/postapi.dart/upload_image.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import 'package:apihandling/getapi.dart/user_practice4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      home: ApiBotton(),
      debugShowCheckedModeBanner: false,
    );
  }
}
