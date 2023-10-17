import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PracticeApi extends StatefulWidget {
  const PracticeApi({super.key});

  @override
  State<PracticeApi> createState() => _PracticeApiState();
}

class _PracticeApiState extends State<PracticeApi> {
  List<Photos> photosList = [];
  Future<List<Photos>> getPhotosApi() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        Photos photos = Photos(title: i['title'], url: i['url']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('api practice'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotosApi(),
                builder: (context, snapshot) {
                  return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(5),
                          leading: Image.network(photosList[index].url),
                          title: Text(photosList[index].title.toString()),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  Photos({required this.title, required this.url});
}
