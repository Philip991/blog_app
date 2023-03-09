import 'package:blog_app/const_values.dart';
import 'package:blog_app/models/posts.dart';
import 'package:blog_app/screens/bookmark_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Bookmark extends StatefulWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  Box? storeData;

  displayTime(String date) {
    return DateFormat.yMMMMEEEEd().format(DateTime.parse(date));
  }

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(appState);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: storeData!.listenable(),
        builder: (context, Box box, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: storeData!.keys.toList().length,
                  itemBuilder: (_, index) {
                    final keys = box.keys.toList()[index];
                    final Posts post = box.get(keys);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return BookmarkView(index: post);
                        }));
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: const Text('Warning'),
                              content: const Text(
                                'You about to removed this from your bookmarks are you sure about this?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('No'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    storeData!.delete(keys);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Yes'),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20, top: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            post.image == null
                                ? Container()
                                : Container(
                                    width: 100,
                                    height: 100,
                                    margin: const EdgeInsets.only(left: 20),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: post.image ?? '',
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
                                    child: post.title == null
                                        ? Container()
                                        : Text(
                                            '${post.title}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                            softWrap: true,
                                            overflow: TextOverflow.fade,
                                          ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: post.date == null
                                        ? Container()
                                        : Text(
                                            '${displayTime(post.date.toString())}',
                                          ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
