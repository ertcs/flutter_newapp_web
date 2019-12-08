import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newapp_web/datamodel/bookmarkmodel.dart';
import 'package:flutter_newapp_web/datamodel/newsmodel.dart';
import 'package:hive/hive.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebViewPage extends StatefulWidget {
  final NewsModel newsModel;



  NewsWebViewPage(this.newsModel);

  @override
  _NewsWebViewPageState createState() => _NewsWebViewPageState();
}

class _NewsWebViewPageState extends State<NewsWebViewPage> {
  bool _isLoadingPage;
  bool _isBookMarked;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key = UniqueKey();
  final snackBar = SnackBar(content: Text('Saved'));
  var box;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<BookMarkModel>("bookmarks");
    _isLoadingPage = true;
    _isBookMarked = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    _isLoadingPage
                        ? Container(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              strokeWidth: 1.0,
                            ),
                          )
                        : Container(
                            height: 10,
                            width: 10,
                          ),
                    IconButton(
                      icon: Icon(
                        _isBookMarked?Icons.bookmark:Icons.bookmark_border,
                        color: Colors.black,
                      ),
                      onPressed: (){
                        setState(() {
                          _isBookMarked=true;
                          if(_isBookMarked){
                            _scaffoldKey.currentState.showSnackBar(snackBar);
                            BookMarkModel bookmarkModel = BookMarkModel(
                              websiteName: widget.newsModel.websiteName,
                              title: widget.newsModel.title,
                              headLine: widget.newsModel.headLine,
                              url: widget.newsModel.url,
                              urlToImage: widget.newsModel.urlToImage,
                              publishedAt: widget.newsModel.publishedAt,
                              content: widget.newsModel.content,
                            );
                            box.add(bookmarkModel);
                          }

                        });
                      },
                    )
                  ],
                ),
                Expanded(
                  child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.newsModel.url,
                    onPageFinished: (finish) {
                      setState(() {
                        _isLoadingPage = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
