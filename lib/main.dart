import 'package:flutter/material.dart';
import 'package:flutter_123/category/category_view.dart';
import 'package:flutter_123/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return _containerView();
  }
  
  Widget _containerView() {
    return DefaultTabController(length: 2, child: MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(tabs: [
            Tab(child: Text("热门", style: TextStyle(color: Colors.black),),),
            Tab(child: Text("分类", style: TextStyle(color: Colors.black),),)
          ], indicatorColor: Colors.green,),
          title: const Text("新闻资讯", style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
          backgroundColor: Colors.white,
        ),
        body: TabBarView(children: [
          HomeView(),
          CategoryView()
        ],),
      ),
    ));
  }
}
