import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_newapp_web/util/getnewsitem.dart';
import 'package:flutter_newapp_web/datamodel/newsmodel.dart';
import 'package:flutter_newapp_web/webpage/webviewpage.dart';

class NewsCardContainer extends StatelessWidget {
  final String newsUrl;
  NewsCardContainer({this.newsUrl});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: FutureBuilder<List<NewsModel>>(
          future: getNewsItem(newsUrl),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null) {
                return ListView.builder(
                  key: ObjectKey(newsUrl),
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return CardListView(
                      model: snapshot.data[index],
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('No Data Available'),
                );
              }
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class CardListView extends StatelessWidget {
  final NewsModel model;
  CardListView({this.model});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NewsWebViewPage(model)));
        },
        child: Container(
          margin: EdgeInsets.only(right: 16),
          height: double.infinity,
          width: kIsWeb ? 300 : MediaQuery.of(context).size.width * 0.80,
          child: Stack(
            children: <Widget>[
              Image.network(
                model.urlToImage,
                width: kIsWeb ? 300 : MediaQuery.of(context).size.width * 0.80,
                height: double.infinity,
                fit: BoxFit.fitHeight,
                colorBlendMode: BlendMode.luminosity,
                gaplessPlayback: true,
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
                        model.title,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: model.lightMutedColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            fontFamily: 'Rajdhani'),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
