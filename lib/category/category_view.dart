import 'package:flutter/material.dart';
import 'package:flutter_123/base/base.dart';
import 'package:flutter_123/category/category_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryViewState();
  }
}

class _CategoryViewState extends State<CategoryView> {
  final List<String> _categorys = [
    "GeneralNews",
    "CarNews",
    "DomesticNews",
     "AnimeNews",
    "FinancialNews",
    "GameNews",
    "InternationalNews",
    "AINews",
    "MilitaryNews",
    "SportNews"
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return _getItem(context, index);
        },
        itemCount: _categorys.length ~/ 2,
      ),
    );
  }

  Widget _getItem(BuildContext context, int index) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130,
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              color: index % 2 == 0 ? Colors.orange : Colors.blueAccent,
              height: 130,
              child: Center(
                child: Text(
                  _categorys[index * 2],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return CategoryListView(CATEGORY_KEYS[_categorys[index * 2]]!, _categorys[index * 2]);
              }));
            },
          ),
          GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              color: index % 2 == 0 ? Colors.blueAccent : Colors.orange,
              height: 130,
              child: Center(
                child: Text(
                  _categorys[index * 2 +1],
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 30, color: Colors.white),
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                return CategoryListView(CATEGORY_KEYS[_categorys[index * 2 + 1]]!, _categorys[index * 2 + 1]);
              }));
            },
          )
        ],
      ),
    );
  }

}
