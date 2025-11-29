import 'package:flutter_riverpod/legacy.dart';
import 'package:hive/hive.dart';
import 'package:web_summarist/features/web_summary/data/models/urls_model.dart';

class UrlsViewModel extends StateNotifier<List<UrlsModel>> {
  static const String boxName = 'urlsBox';
  UrlsModel? _lastDeleted;

  late Box<UrlsModel> _box;

  UrlsViewModel() : super([]) {
    _init();
  }

  Future<void> _init() async {
    _box = await Hive.openBox<UrlsModel>(boxName);
    state = _box.values.toList();
  }

  Future<void> addUrl(UrlsModel urlModel) async {
    final exists = _box.values.any((u) => u.url == urlModel.url);
    if (exists) return;
    await _box.add(urlModel);
    state = _box.values.toList();
  }

  Future<void> removeUrl(int index) async {
    _lastDeleted = state[index];
    await _box.deleteAt(index);
    state = _box.values.toList();
  }

  Future<void> undoRemoveUrl() async {
    if (_lastDeleted != null) {
      await _box.add(_lastDeleted!);
      state = _box.values.toList();
      _lastDeleted = null;
    }
  }
}
