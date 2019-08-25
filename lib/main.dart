import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'matchmaking_data.dart';

Future<GetGame> fetchPost() async {
  final response =
      await http.get('https://multiplayer.factorio.com/get-games?username=SimonFlapse&token=8186a2f2ad3e451d46a75fed3498f1');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return GetGame.fromJson(json.decode(response.body)[4]);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

void main() => runApp(MyApp(post: fetchPost()));

class MyApp extends StatelessWidget {
  final Future<GetGame> post;

  MyApp({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<GetGame>(
            future: post,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Flexible(child: Text(snapshot.data.name + ' ' + snapshot.data.gameTimeElapsed.toString())
                    ),
                    Divider(),
                    Flexible(
                      child: Text(snapshot.data.players == null ? 'No players online' : snapshot.data.players[0])
                    ),
                  ],);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}