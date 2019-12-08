import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_newapp_web/searchpage_widget/searchwidgetpage.dart';
import 'package:hive/hive.dart';

import 'datamodel/bookmarkmodel.dart';
import 'home_page_widgets/tab_list_view.dart';
import 'package:flutter_newapp_web/datamodel/tabbardata.dart';
import 'home_page_widgets/homebarwidget.dart';
import 'package:provider/provider.dart';
import 'home_page_widgets/bottomnavigationbar.dart';
import 'util/appUtil.dart';
import 'home_page_widgets/newscardcontainer.dart';
import 'dart:ui';
import 'package:path_provider/path_provider.dart' as path_provider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(BookMarkModelAdapter(), 0);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Daily News',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: Hive.openBox<BookMarkModel>("bookmarks"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError)
                return Text(snapshot.error.toString());
              else
                return MyHomePage();
            }
            // Although opening a Box takes a very short time,
            // we still need to return something before the Future completes.
            else
              return Scaffold();
          },
        ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => TabBarData(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          elevation: 0,
          actions: <Widget>[
            UserImageIcon(),
          ],
        ),
        body: PagesLayout(),
        bottomNavigationBar: BottomNavigationMenu(),
      ),
    );
  }
}

class PagesLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabBarData>(
      builder: (context, data, child) {
        Widget tabWidget;
        switch (data.bottomIndex) {
          case 0:
            {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      'Daily News',
                      style: mainHeadingStyle,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TabListView(),
                    NewsCardContainer(
                        newsUrl: data
                            .tabBarModel(index: data.activeIndex)
                            .getNewsUrl()),
                  ],
                ),
              );
            }
          case 1:
            {
              return SearchListWidget();
            }
          case 2:
            {
              return BookMarkPage();
            }
        }
        return tabWidget;
      },
    );
  }
}

class BookMarkPage extends StatelessWidget {
  final bookmarkBox = Hive.box<BookMarkModel>("bookmarks");
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Center(
            child: Text(
          "BookMarks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        )),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: bookmarkBox.length > 0
              ? ListView.builder(
                  itemCount: bookmarkBox.length,
                  itemBuilder: (BuildContext context, int index) {
                    final bookMark = bookmarkBox.get(index);
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 0.5)
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 4,right: 10),
                              child: Image.network(bookMark.urlToImage,height: 100,width: 100,),
                            ),
                            Expanded(child: Text(bookMark.title),)
                          ],
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Text('No BookMarks'),
                ),
        ),
      ],
    );
  }
}
