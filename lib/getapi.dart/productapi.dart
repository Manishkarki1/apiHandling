import 'dart:convert';

import 'package:apihandling/getapi.dart/models/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductApi extends StatefulWidget {
  const ProductApi({super.key});

  @override
  State<ProductApi> createState() => _ProductApiState();
}

class _ProductApiState extends State<ProductApi> {
  Future<ProductModel> getProductApi() async {
    final response = await http.get(Uri.parse(
        'https://webhook.site/4f5fcf97-bd42-4eee-b2af-b2a695c4578a '));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('complex JSON Data'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<ProductModel>(
                  future: getProductApi(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('loading');
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [Text(index.toString())],
                            );
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
