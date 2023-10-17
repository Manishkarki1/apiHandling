import 'package:apihandling/getapi.dart/models/postmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    final data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api practice'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      width: 25,
                      height: 10,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Text(postList[index].id.toString()),
                          title: Text(postList[index].title.toString()),
                        );
                      }, 
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: postList.length,
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
