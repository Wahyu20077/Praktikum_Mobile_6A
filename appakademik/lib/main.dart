import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'views/mahasiswa_view01.dart';
//import 'views/matakuliah_view.dart';
//import 'views/jadwal_view.dart';
import 'views/homescreen.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mahasiswa App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      //home: MahasiswaView(),
    );
  }
}