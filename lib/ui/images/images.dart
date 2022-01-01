import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:example_test/api/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesPage extends StatelessWidget {
  final String breed;

  const ImagesPage(this.breed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('IMAGES')),
      body: FutureBuilder(
        future: api.getBreedImages(breed),
        builder: (_, AsyncSnapshot<String> snapshot) {
          var data = snapshot.data;

          if (snapshot.hasData) {
            if (data != null) {
              Map<String, dynamic> result = jsonDecode(data);

              String status = result['status']; // success

              if (status == 'success') {
                var message = result['message'];
                return ListView(
                  children: message
                      .map<Widget>((e) => ListTile(
                            title: CachedNetworkImage(
                              imageUrl: e,
                              placeholder: (context, url) => Container(
                                child: const CircularProgressIndicator(),
                                alignment: Alignment.center,
                                height: 120,
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                          ))
                      .toList(),
                );
              }
            }
            return const Center(
              child: Text(
                'Empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          // Error
          else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return const Center(child: CupertinoActivityIndicator());
        },
      ),
    );
  }
}
