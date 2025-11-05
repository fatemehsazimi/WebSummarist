import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UrlListViewModel extends StateNotifier<List<String>> {
  UrlListViewModel() : super([]) {
    _loadUrls();
  }

  String? _lastDeletedUrl;

  Future<void> _loadUrls() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getStringList('myStringList') ?? [];
  }

  Future<void> addUrl(String url) async {
    if (state.contains(url)) return;
    final prefs = await SharedPreferences.getInstance();
    final updated = [...state, url];
    await prefs.setStringList('myStringList', updated);
    state = updated;
  }

  Future<void> removeUrl(String url) async {
    _lastDeletedUrl = url;
    final prefs = await SharedPreferences.getInstance();
    final updated = state.where((e) => e != url).toList();
    await prefs.setStringList('myStringList', updated);
    state = updated;
  }

  Future<void> undoRemoveUrl() async {
    if (_lastDeletedUrl == null) return;
    final prefs = await SharedPreferences.getInstance();
    final updated = [...state, _lastDeletedUrl!];
    await prefs.setStringList('myStringList', updated);
    state = updated;
    _lastDeletedUrl = null;
  }
}
