import 'dart:convert';

import 'package:apihandling/getapi.dart/models/Dropdownmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiBotton extends StatefulWidget {
  const ApiBotton({super.key});

  @override
  State<ApiBotton> createState() => _ApiBottonState();
}

class _ApiBottonState extends State<ApiBotton> with TickerProviderStateMixin {
  Future<List<DropdownModel>> getApi() async {
    try {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final data = jsonDecode(response.body.toString()) as List;
      if (response.statusCode == 200) {
        return data.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownModel(
            id: map['id'],
            title: map['title'],
            body: map['body'],
            userId: map['userId'],
          );
        }).toList();
      }
    } catch (e) {
      print(e.toString());
    }
    throw Exception("error fetching the data");
  }

  var selectedValue;
  late AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 2))
        ..repeat();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Load Api to Dropdown menu'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<DropdownModel>>(
              future: getApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SpinKitFadingCircle(
                    duration: Duration(seconds: 3),
                    color: const Color.fromARGB(255, 32, 31, 31),
                    controller: _controller,
                  );
                } else {
                  return Center(
                    child: DropdownButton(
                        isExpanded: true,
                        value: selectedValue,
                        hint: Text('Select value'),
                        items: snapshot.data!.map((e) {
                          return DropdownMenuItem(
                            
                            value: e.id.toString(),
                            child: Text(e.id.toString()),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                          });
                        }),
                  );
                }
              })
        ],
      ),
    );
  }
}
