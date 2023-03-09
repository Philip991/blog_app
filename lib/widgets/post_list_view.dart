import 'package:blog_app/config/api_config.dart';
import 'package:blog_app/models/posts.dart';
import 'package:blog_app/screens/post_view.dart';
import 'package:blog_app/widgets/refresh.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PostListView extends StatefulWidget {
  const PostListView({Key? key}) : super(key: key);

  @override
  _PostListViewState createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  ApiConfig api = ApiConfig();

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  displayTime(String date) {
    return DateFormat.yMMMMEEEEd().format(DateTime.parse(date));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: FutureBuilder(
        future: api.fetchListPosts(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
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
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(left: 20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: '${post.image}',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                            placeholder: (_, url) {
                              return Image.asset(
                                'assets/images/loading.gif',
                                width: 50,
                                height: 50,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${post.title!.substring(0, 20)}...',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  '${displayTime(post.date.toString())}',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Column(
                children: <Widget>[
                  const Text(
                    'Check your Internet connection and try again',
                    style: TextStyle(),
                  ),
                  Refresh(
                    text: 'Refresh',
                    onPressed: () {
                      setState(() {});
                    },
                  ),
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
                      'Please Check your internet connection and try again.',
                      style: TextStyle(),
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Refresh(
                    text: 'Refresh',
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
