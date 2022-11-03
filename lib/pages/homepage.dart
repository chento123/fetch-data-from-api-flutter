import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List MyLs = [];
  Future<List> GetLs() async {
    var url = 'https://jsonplaceholder.typicode.com/posts';
    var rp = await http.get(Uri.parse(url));
    if (rp.statusCode == 200) {
      MyLs = jsonDecode(rp.body);
    }
    return MyLs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: GetLs(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ID    :   ${MyLs[index]["id"]}"),
                        Text("Title    :   ${MyLs[index]["title"]}"),
                        Text("Body    :   ${MyLs[index]["body"]}"),
                      ],
                    ),
                  );
                }));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
