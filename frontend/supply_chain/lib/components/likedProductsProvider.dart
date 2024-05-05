import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedProductsProvider extends ChangeNotifier {
  late SharedPreferences _prefs;
  List<String> _likedProductIds = [];

  List<String> get likedProductIds => _likedProductIds;

  LikedProductsProvider() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _likedProductIds = _prefs.getStringList('likedProducts') ?? [];
  }

  Future<void> _saveLikedProducts() async {
    await _prefs.setStringList('likedProducts', _likedProductIds);
  }

  void toggleLiked(String productId) {
    if (_likedProductIds.contains(productId)) {
      _likedProductIds.remove(productId);
    } else {
      _likedProductIds.add(productId);
    }
    _saveLikedProducts();
    notifyListeners();
  }
}
