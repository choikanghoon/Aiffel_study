import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ),
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text('Jellyfish Classifier'),
              centerTitle: true,
              leading: Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: SvgPicture.asset(
                    'images/jellyfish_icon.svg',
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
            body: TestScreen()));
  }
}

class TestScreen extends StatefulWidget {
  @override
  _MyBody createState() => _MyBody();
}

class _MyBody extends State<TestScreen> {
  String result1 = ''; // 결과 labeling
  String result2 = ''; // 확률 acc

  Future<void> fetchData() async {
    try {
      final enteredUrl = "https://6e00-34-127-90-63.ngrok-free.app/";
      final response = await http.get(
        Uri.parse(enteredUrl + "sample"),
        headers: {
          'Content-Type': 'application/json',
          'ngrok-skip-browser-warning': '69420',
        },
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          result1 = "predicted_label: ${data['predicted_label']}";
          result2 = "prediction_score: ${data['prediction_score']}";
        });
      } else {
        setState(() {
          result1 = "Failed to fetch data. Status Code: ${response.statusCode}";
          result2 = "Failed to fetch data. Status Code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        result1 = "Error : $e";
        result2 = "Error : $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              color: Colors.orange,
              image: DecorationImage(
                image: AssetImage('images/jellyfish.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            width: 300,
            height: 220,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  fetchData();
                  print(result1);
                },
                child: Text("예측 결과"),
              ),
              SizedBox(
                width: 50,
                height: 200,
              ),
              ElevatedButton(
                onPressed: () {
                  fetchData();
                  print(result2);
                },
                child: Text("예측 확률"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
