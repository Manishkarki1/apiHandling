import 'dart:convert';

import 'package:apihandling/getapi.dart/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserGetApi extends StatefulWidget {
  const UserGetApi({super.key});

  @override
  State<UserGetApi> createState() => UserGetApiState();
}

class UserGetApiState extends State<UserGetApi> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User api'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(snapshot.data![index].name.toString()),
                                    Spacer(),
                                    Text(userList[index]
                                        .address!
                                        .city
                                        .toString()),
                                  ],
                                )
                              ],
                            ),
                          );
                        });
                  }))
        ],
      ),
    );
  }
}
