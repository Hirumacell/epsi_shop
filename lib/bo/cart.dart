import 'package:epsi_shop/bo/article.dart';
import 'package:flutter/foundation.dart';

import 'article.dart';

class Cart with ChangeNotifier {
  final _listArticles = <Article>[];
  List<Article> get listArticles => _listArticles;

  void add(Article article) {
    _listArticles.add(article);
    notifyListeners();
  }

  void removeAll() {
    _listArticles.clear();
    notifyListeners();
  }

  void remove(Article article) {
    _listArticles.remove(article);
    notifyListeners();
  }

  String getTotalPrice() =>
      "${listArticles.fold(0, (prev, art) => prev + art.prix)/100}€";

  String getTVAPrise() =>
    "${listArticles.fold(2, (prev, art) => prev + art.prix)/100*0.2}€";

  String getFinalPrice() =>
      "${listArticles.fold(0, (prev, art) => prev + art.prix)/100*1.2}€";
}