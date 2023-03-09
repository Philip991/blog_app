import 'dart:convert';

import 'package:blog_app/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

class ApiConfig {
  static const api = 'https://naijatechguy.com/wp-json/wp/v2/';
  // static const headlineApi =
  //     'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=' +
  //         API_KEY;
  // static const API_KEY = '92afd68ba1dd4693b94753aba475fd7f';
  static const headers = {'Accept': 'application/json'};

  String _parseHtmlString(String htmlString) {
    try {
      var document = parse(htmlString);
      String? parsedString = parse(document.body!.text).documentElement!.text;
      return parsedString;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }

  //call for Gadget articles
  Future<List<Posts>> fetchListPosts() async {
    List<Posts> posts = [];
    try {
      var response = await http.get(
        Uri.parse(api + "posts?_embed&categories=467"),
        //Uri.parse(api),
        headers: headers,
      );

      var convertDataToJson = await jsonDecode(response.body);

      convertDataToJson.forEach((post) {
        String title = _parseHtmlString(post['title']['rendered']);

        var content = _parseHtmlString(post['content']['rendered']);
        var date = post['date'];

        var imageUrl = post['_embedded']['wp:featuredmedia'] != null
            ? post['_embedded']['wp:featuredmedia'][0]['source_url']
            : Image.network(
                'assets/images/error_img.jpg',
                fit: BoxFit.cover,
                width: 100,
                height: 90,
              );

        posts.add(Posts(
          title: title,
          content: content,
          date: date,
          image: imageUrl,
        ));
      });
      return posts;
    } catch (e) {
      print(e.toString());
      throw (e);
    }
  }
}
