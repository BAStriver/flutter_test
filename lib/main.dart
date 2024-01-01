import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_123/category/category_view.dart';
import 'package:flutter_123/collection/collection_view.dart';
import 'package:flutter_123/home/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _AppPage(),
    );
  }
}

class _AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _containerView(context);
  }

  Widget _containerView(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(
                    child: Text(
                      "popular",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "classifications",
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
                indicatorColor: Colors.green,
              ),
              title: const Text(
                "ALl News",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.white,
              actions: <Widget>[
                GestureDetector(
                  child: Container(
                    width: 60,
                    child: const Icon(Icons.collections),
                  ),
                  onTap: () {
                    print('enter collection view.');
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      print('enter collection view2.');
                      return CollectionView();
                    }));
                  },
                )
              ],
            ),
            body: TabBarView(
              children: [HomeView(), CategoryView()],
            ),
          )),
    );
  }
}