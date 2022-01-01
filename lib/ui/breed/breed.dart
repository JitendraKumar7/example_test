import 'dart:convert';

import 'package:example_test/api/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BREED')),
      body: FutureBuilder(
        future: api.getBreed(),
        builder: (_, AsyncSnapshot<String> snapshot) {
          var data = snapshot.data;

          if (snapshot.hasData) {
            if (data != null) {
              Map<String, dynamic> result = jsonDecode(data);

              debugPrint('message result $result');
              String status = result['status']; // success

              if (status == 'success') {
                Map<String, dynamic> message = result['message'];
                return ListView(
                    children: message.keys
                        .map((e) => Card(
                              child: ListTile(
                                title: Text(e),
                                onTap: () {
                                  debugPrint('message key $e');
                                  var route = MaterialPageRoute(
                                      builder: (_) => ImagesPage(e));
                                  Navigator.push(context, route);
                                },
                              ),
                            ))
                        .toList());
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
