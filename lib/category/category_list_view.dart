import 'package:flutter/material.dart';
import 'package:flutter_123/mode/home_model.dart';
import 'package:flutter_123/mode/new_model.dart';
import 'package:flutter_123/tool/net_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryListView extends StatefulWidget {
  String path;
  String title;

  CategoryListView(this.path, this.title, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CategoryListViewState(path, title);
  }
}

class _CategoryListViewState extends State<CategoryListView> {
  late ScrollController _scrollController;
  final NetManager _netManager = NetManager();
  final List<News> _dataList = [];
  int _currentPage = 1;
  late String path;
  late String title;

  _CategoryListViewState(this.path, this.title);

  @override
  void initState() {
    super.initState();

    // mock to refresh
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print('refreshing.');
          _requestData(_currentPage);
        }
      });

    _requestData(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    AppBar _appbar = AppBar(
      title: Text(title),
    );

    return Scaffold(
      appBar: _appbar,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height:
            MediaQuery.of(context).size.height - _appbar.preferredSize.height,
        color: Colors.white,
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              // build view list
              return _buildItem(context, index);
            },
            itemCount: _dataList.length,
            controller: _scrollController,
          ),
        ),
      ),
    );
  }

  // dropdown refresh
  Future<Null> _onRefresh() async {
    print('refreshing...');
    _currentPage = 1;
    await _requestData(_currentPage);
  }

  Future _requestData(int page) async {
    print("page: " + page.toString());
    print("path: " + path.toString());
    HomeModel data = await _netManager.queryDataByWord(page, path);
    if (page == 1) {
      _dataList.clear();
      _dataList.addAll(data.result.newslist);
    } else {
      // load more data
      _dataList.addAll(data.result.newslist);
    }
    _currentPage++;

    setState(() {});
    return;
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 1),
      color: Colors.amber,
      child: GestureDetector(
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.grey,
              child: Image.network(
                // "http://n.sinaimg.cn/sinakd202124s/162/w550h412/20210204/6706-kirmait9301473.jpg",
                _dataList[index].picUrl,
                width: 130,
                height: 110,
                fit: BoxFit.fitHeight,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
                  width: MediaQuery.of(context).size.width - 130 - 20,
                  child: Text(
                    _dataList[index].title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(_dataList[index].description),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(_dataList[index].ctime),
                ),
              ],
            )
          ],
        ),
        onLongPress: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Do you want to save it ?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          _addCollection(
                              _dataList[index].id, _dataList[index].title);
                          Navigator.of(context).pop();
                        },
                        child: Text('Yes')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('No')),
                  ],
                );
              });
        },
      ),
    );
  }

  void _addCollection(String id, String title) async {
    print('id: ' + id);
    print('title: ' + title);
    SharedPreferences? preferences = await SharedPreferences.getInstance();
    String? data = preferences.getString(id);
    if (data == null) {
      await preferences.setString(id, title);
      Fluttertoast.showToast(msg: 'saved successfully.');
    } else {
      Fluttertoast.showToast(msg: 'the new already existing.');
    }
  }
}
