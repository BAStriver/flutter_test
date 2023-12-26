import 'package:flutter/material.dart';
import 'package:flutter_123/mode/home_model.dart';
import 'package:flutter_123/mode/new_model.dart';
import 'package:flutter_123/tool/net_manager.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  late ScrollController _scrollController;
  final NetManager _netManager = NetManager();

  late final List<News> _dataList = [];
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();

    // mock to refresh
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print('refreshing.');
        }
      });

    _requestData(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              // build swiper widget
              return _buildSwiper(context);
            } else {
              // build view list
              return _buildItem(context, index + 2);
            }
          },
          itemCount: _getItemCount(),
        ),
      ),
    );
  }

  // dropdown refresh
  Future<Null> _onRefresh() async {
    print('refreshing...');
    _currentPage = 1;
    await _requestData(_currentPage);
    // await Future.delayed(const Duration(seconds: 3), () {
    //   print('dropdown to refresh.');
    // });
  }

  int _getItemCount() {
    if (_dataList.length > 3) {
      return _dataList.length - 3 + 1;
    } else {
      return 0;
    }
  }

  // handle swapper
  Widget _buildSwiper(BuildContext context) {
    return Container(
      height: 150,
      child: Swiper(
        pagination: const SwiperPagination(),
        control: const SwiperControl(),
        autoplay: true,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            color: Colors.orange,
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Image.network(_dataList[_dataList.length-1].picUrl,
            height: 150, width: MediaQuery.of(context).size.width, fit: BoxFit.fitWidth,),
          );
        },
      ),
    );
  }

  // handle view list
  Widget _buildItem(BuildContext context, int index) {
    return Container(
      height: 110,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 1),
      color: Colors.amber,
      child: Row(
        children: <Widget>[
          Container(
            color: Colors.grey,
            child: Image.network(
              // "http://n.sinaimg.cn/sinakd202124s/162/w550h412/20210204/6706-kirmait9301473.jpg",
              _dataList[_dataList.length-1].picUrl,
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
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
    );
  }

 Future _requestData(int page) async {
    print("page: "+ page.toString());
    HomeModel data = await _netManager.queryHomeData(page);
    if(page == 1) {
      _dataList.clear();
      _dataList.addAll(data.result.newslist);
    } else {
      // load more data
      _dataList.addAll(data.result.newslist);
    }
    _currentPage ++;

    setState(() {});
    return;
  }
}
