import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: getToken(),
          builder: (_, s) => Center(
                child: Text("data: ${s.data}"),
              )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<String> getToken() async {
  var response = await Dio().post(
    "https://apps.leader-id.ru/api/v1/oauth/token",
    data: {
      "client_id": "69dac9f2-f8ee-44b9-a478-be44b0be4469",
      "client_secret": "GkNHwtZEVeoLEPqTgUYZ0v7dmMYmRIfJ",
      "grant_type": "client_credentials",
    },
  );
  // var response = await Dio().post(
  //   Uri.https('apps.leader-id.ru', "/api/v1/oauth/token"),
  //   body: {
  //     "client_id": "69dac9f2-f8ee-44b9-a478-be44b0be4469",
  //     "client_secret": "GkNHwtZEVeoLEPqTgUYZ0v7dmMYmRIfJ",
  //     "grant_type": "client_credentials",
  //   },
  // );
  print(jsonDecode(response.data));
  return jsonDecode(response.data)["access_token"];
}
