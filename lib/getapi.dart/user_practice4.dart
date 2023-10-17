import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserApiPractice extends StatefulWidget {
  const UserApiPractice({super.key});

  @override
  State<UserApiPractice> createState() => _UserApiPracticeState();
}

class _UserApiPracticeState extends State<UserApiPractice> {
  //if we can't make the model of JSON then we can use following way:
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Json without model'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(data[0]['name'].toString());
                    }
                  }))
        ],
      ),
    );
  }
}
