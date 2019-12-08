
import 'package:flutter_newapp_web/webpage/webviewpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newapp_web/datamodel/newsmodel.dart';
import 'package:flutter_newapp_web/util/appUtil.dart';

class SearchListWidget extends StatefulWidget {
  @override
  _SearchListWidgetState createState() => _SearchListWidgetState();
}

class _SearchListWidgetState extends State<SearchListWidget> {


  final SearchBarController<NewsModel> _searchBarController =
      SearchBarController();

  Future<List<NewsModel>> _getALlPosts(String text) async {
    String urlKey =
        'https://newsapi.org/v2/everything?q=$text&sortBy=popularity&apiKey=$newsApiKey';
    final List<NewsModel> newsModel = [];
    String defaultImage =
        'https://nbhc.ca/sites/default/files/styles/article/public/default_images/news-default-image%402x_0.png?itok=d03WAFvJ';

    http.Response response = await http.get(urlKey);

    if (response.statusCode == 200) {
      String data = response.body;

      for (int i = 0; i < 20; i++) {
        String websiteName =
            jsonDecode(data)['articles'][i]['source']['name'].toString();
        String title = jsonDecode(data)['articles'][i]['title'].toString();
        String headLine =
            jsonDecode(data)['articles'][i]['description'].toString();
        String url = jsonDecode(data)['articles'][i]['url'].toString();
        String urlToImage =
            jsonDecode(data)['articles'][i]['urlToImage'].toString();
        String publishedAt =
            jsonDecode(data)['articles'][i]['publishedAt'].toString();
        String content = jsonDecode(data)['articles'][i]['content'].toString();

//      print("utlimage: $i:  $urlToImage");

        newsModel.add(NewsModel(
          websiteName: websiteName,
          title: title,
          headLine: headLine,
          url: url,
          urlToImage: urlToImage.length > 50 ? urlToImage : defaultImage,
          publishedAt: publishedAt,
          content: content,
          darkVibrantColor: Colors.black,
          lightMutedColor: Colors.white,
        ));
      }
    }

    return newsModel;
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar<NewsModel>(
      searchBarPadding: EdgeInsets.symmetric(horizontal: 15),
      headerPadding: EdgeInsets.symmetric(horizontal: 1),
      listPadding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
      onSearch: _getALlPosts,
      searchBarController: _searchBarController,
      placeHolder: Center(child: Text("Search")),
      hintText: "search",
      cancellationText: Text("Cancle"),
      emptyWidget: Text("empty"),
      mainAxisSpacing: 10,
      crossAxisSpacing: 0,
      onItemFound: (NewsModel post, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewsWebViewPage(post)));
          },
          child: Container(
            height: 250,
            color: Colors.grey[200],
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.network(
                  post.urlToImage,
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.luminosity,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          post.title,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: post.lightMutedColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              fontFamily: 'Rajdhani'),
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
