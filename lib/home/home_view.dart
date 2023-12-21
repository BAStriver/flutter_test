import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            // 构建轮播组件
            return Container(
              height: 150,
              child: Swiper(
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
                autoplay: true,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.orange,
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Center(
                      child: Text(
                        "image$index",
                        style: const TextStyle(fontSize: 50),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            //   构建列表组件
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
                      "",
                      width: 130,
                      height: 110,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin:
                            const EdgeInsets.only(left: 10, top: 10, right: 10),
                        width: MediaQuery.of(context).size.width - 130 - 20,
                        child: const Text(
                          "News title",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text("News source"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text("Emit time"),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
        itemCount: 10,
      ),
    );
  }
}
