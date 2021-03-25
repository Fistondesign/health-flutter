import 'package:flutter/material.dart';
import 'package:itakubuzima/pages/ahabanza.dart';
import 'package:itakubuzima/pages/detailpage.dart';
import 'homepage.dart';
import './pages/menya.dart';
import './pages/ubutumwa.dart';
import './pages/items.dart';
import './pages/detailpage.dart';
import './pages/ahabanza.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       routes:{
         '/ahabanza':(context)=>Ahabanza(),
          '/menya':(context)=>Menya(),
         '/ubutumwa':(context)=>Ubutumwa(),
         '/':(context)=>HomePage(),
         '/items':(context)=>Items(),
         '/detailpage':(context)=>Detailpage(),
         
       },
      title: 'ITAKUBUZIMA',
      debugShowCheckedModeBanner: false,
    );
  }
}


