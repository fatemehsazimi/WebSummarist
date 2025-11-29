import 'package:hive/hive.dart';

part 'urls_model.g.dart'; // This file will be generated

@HiveType(typeId: 0) // Unique typeId for each model
class UrlsModel {
  @HiveField(0)
  late String url;

  @HiveField(1)
  late String summaryresult;

  @HiveField(2)
  late DateTime date;

  UrlsModel({required this.url, required this.summaryresult, required this.date});
}