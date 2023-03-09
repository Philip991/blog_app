import 'package:blog_app/const_values.dart';
import 'package:blog_app/widgets/horizontal_view.dart';
import 'package:blog_app/widgets/post_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var dateFormat = DateFormat.yMMMMEEEEd().format(DateTime.now());

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Box? storeData;

  @override
  void initState() {
    super.initState();
    const HorizontalView();
    const PostListView();
    storeData = Hive.box(appState);
  }

  void _onRefresh() async {
    //monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() {});
    }
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    //monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));

    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 290,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(33),
                          bottomRight: Radius.circular(33),
                        ),
                      ),
                      child: Container(
                        height: 290,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Latest News',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      '$dateFormat',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            HorizontalView(),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 30, bottom: 10, top: 15),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Gadgets',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                    PostListView(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
