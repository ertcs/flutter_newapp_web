import 'package:hive/hive.dart';



part 'bookmarkmodel.g.dart';
@HiveType()
class BookMarkModel{
  @HiveField(0)
  String websiteName;

  @HiveField(1)
  String title;

  @HiveField(2)
  String headLine;

  @HiveField(3)
  String url;

  @HiveField(4)
  String urlToImage;

  @HiveField(5)
  String publishedAt;

  @HiveField(6)
  String content;


  BookMarkModel({this.websiteName,this.title,this.headLine,this.url,this.urlToImage,this.publishedAt,this.content});

}