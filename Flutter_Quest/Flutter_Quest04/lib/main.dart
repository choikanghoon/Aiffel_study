// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_svg/flutter_svg.dart';

// void main() {
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         appBarTheme: AppBarTheme(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.black,
//           elevation: 1,
//         ),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Jellyfish Classifier'),
//           centerTitle: true,
//           leading: Center(
//             child: SizedBox(
//               width: 50,
//               height: 50,
//               child: SvgPicture.asset(
//                 'images/jellyfish_icon.svg',
//                 color: Colors.pink,
//               ),
//             ),
//           ),
//         ),
//         body: Center(
//           child: Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: 80),
//                 decoration: BoxDecoration(
//                     color: Colors.orange,
//                     image: DecorationImage(
//                         image: AssetImage('images/jellyfish.jpg'),
//                         fit: BoxFit.cover)),
//                 width: 300,
//                 height: 220,
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     ElevatedButton(onPressed: onPressed, child: child)
//                     ElevatedButton(onPressed: onPressed, child: child)
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
