import 'dart:async';

import 'package:flutter/material.dart';
import 'package:havelsanapiodevicreate/model.dart';
import 'package:http/http.dart' as http;

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
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Future<UserElement?> submitUser(
    String name, String surname, String lessonsId) async {
  var response = await http.post(Uri.http('localhost:3000', '/user'),
      body: {"name": name, "surname": surname, "lessonsId": lessonsId});
  var data = response.body;
  print(data!);
  if (response.statusCode == 201) {
    String responseString = response.body;
    userFromJson(responseString);
  } else
    return null;
}

class _HomeState extends State<Home> {
  // final url = Uri.parse('http://localhost:3000/user');
  // int? counter;
  // var userResult;

  // Future callUser() async {
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       var result = userFromJson(response.body);
  //       //  print(result.user![0].name);

  //       if (mounted) {
  //         setState(() {
  //           counter = result.user?.length;
  //           userResult = result;
  //         });
  //       }
  //       return result;
  //     } else {
  //       print(response.statusCode);
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   callUser();
  // }

  late UserElement? _userElement;
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController lessonsIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rest API "),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'İsminizi giriniz'),
              controller: nameController,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Soyisminizi giriniz'),
              controller: surnameController,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ders numarası(id) giriniz'),
              controller: lessonsIdController,
            ),
            ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String surname = surnameController.text;
                  String lessonsId = lessonsIdController.text;
                  UserElement? user =
                      await submitUser(name, surname, lessonsId);
                  setState(() {
                    _userElement = user;
                  });
                },
                child: Text("Derse Kayıt Ol")),
            // Expanded(
            //     child: counter != null
            //         ? ListView.builder(
            //             itemCount: counter,
            //             itemBuilder: (context, index) {
            //               return ListTile(
            //                 title: Text(userResult.user[index].name),
            //                 leading:
            //                     CircleAvatar(backgroundColor: Colors.orange),
            //               );
            //             })
            //         : Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }
}
