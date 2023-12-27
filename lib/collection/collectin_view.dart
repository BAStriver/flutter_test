
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CollectionView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CollectionViewState();
  }
}

class _CollectionViewState extends State<CollectionView> {

  final List<Map<String, String>> _data = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appBar = AppBar(title: const Text('Collections'),);
    return Scaffold(
      appBar: _appBar,
      body: Container(
        color: Colors.black26,
        child: ListView.builder(itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, index);
        }, itemCount: _data.length,),
      ),
    );
  }

  void _initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Set<String> keys = preferences.getKeys();
    for(String key in keys) {
      String? value = await preferences.getString(key);
      _data.add({key: value.toString()});
      print('value: ' + value.toString());
    }
    setState(() {
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    return Dismissible(key: Key('$index'),
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red, child:
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(margin: const EdgeInsets.only(right: 10),child: const Text('delete', style: TextStyle(color: Colors.white),),)
          ],
        ),),
      child: GestureDetector(
          child: Container(child: Center(child: Text(_data[index].values.last, style: const TextStyle(fontSize: 15),)),),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            //   return DetailView(_data[index].keys.last, _data[index].values.last);
            // }));
          },
        ),
      onDismissed: (direstion) {
        if (direstion == DismissDirection.endToStart) {
          _removeDataAt(index);
        }
      },
    );
  }

  void _removeDataAt(int index) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(_data[index].keys.last);
    _data.removeAt(index);
    this.setState(() {
    });
    Fluttertoast.showToast(msg: 'deleted successfully.');
  }
}