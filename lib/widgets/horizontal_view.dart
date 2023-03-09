import 'package:auto_size_text/auto_size_text.dart';
import 'package:blog_app/models/posts.dart';
import 'package:blog_app/screens/post_view.dart';
import 'package:blog_app/widgets/refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/api_config.dart';

class HorizontalView extends StatefulWidget {
  const HorizontalView({Key? key}) : super(key: key);

  @override
  _HorizontalViewState createState() => _HorizontalViewState();
}

class _HorizontalViewState extends State<HorizontalView> {
  ApiConfig api = ApiConfig();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.fetchListPosts(),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                Posts post = snapshot.data[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) {
                        return PostView(
                          posts: post,
                        );
                      }),
                    );
                  },
                  child: Column(
                    children: <Widget>[
                      post.image != null
                          ? Container(
                              width: 250,
                              height: 150,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: '${post.image}',
                                fit: BoxFit.cover,
                                width: 250,
                                height: 150,
                                placeholder: (_, url) {
                                  return Image.asset(
                                    'assets/images/loading.gif',
                                    width: 50,
                                    height: 50,
                                  );
                                },
                              ),
                            )
                          : Container(
                              width: 250,
                              height: 150,
                              margin: const EdgeInsets.only(left: 20),
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15.0),
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/error_img.jpg",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Expanded(
                        child: Container(
                          width: 250,
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              '${post.title}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              maxLines: 2,
                              minFontSize: 15,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return Center(
            child: Column(
              children: <Widget>[
                const Text(
                  'Check your internet connection, and refresh',
                  style: TextStyle(),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Refresh(
                  text: 'Refresh',
                  onPressed: () {
                    setState(() {});
                  },
                )
              ],
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: Image.asset(
                  'assets/images/loading.gif',
                  width: 350,
                  height: 200,
                ),
              ),
            ],
          );
        } else {
          return Center(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Check your internet connection',
                    style: TextStyle(),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                Refresh(
                  text: 'Refresh',
                  onPressed: () {
                    setState(
                      () {},
                    );
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }
}
