import 'package:hive/hive.dart';
import '../models/urls_model.dart';

class UrlsRepository {
  final Box<UrlsModel> _box = Hive.box<UrlsModel>('urlsBox');

  Future<void> addUrl(UrlsModel urlModel) async {
    await _box.add(urlModel);
  }

  List<UrlsModel> getAllUrls() {
    return _box.values.toList();
  }

  Future<void> deleteUrl(int index) async {
    await _box.deleteAt(index);
  }

  Future<void> clearAll() async {
    await _box.clear();
  }
}
