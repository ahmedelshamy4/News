import 'package:flutter/cupertino.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:news/model/article.dart';

import '../utils/helper/database_helper.dart';
import 'database_states.dart';

class DatabaseViewModel extends ChangeNotifier {
  DatabaseStates databaseStates = DatabaseStates.InitialState;
  List<Article> _savedArticles = [];

  List<Article> get savedArticles => _savedArticles;

  String? _successMessage;

  String? get successMessage => _successMessage;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  DatabaseMessagesStates? databaseMessagesStates;

  final DatabaseHelper _databaseHelper = DatabaseHelper.dbHelper;

  Future<void> getSavedArticlesFromDatabase() async {
    await _databaseHelper.getAllSavedArticles().then(
      (value) {
        _savedArticles = value;
        databaseStates = DatabaseStates.LoadedState;
      },
    );
    notifyListeners();
  }

  Future<void> addNewArticle(Article article) async {
    for (int i = 0; i < _savedArticles.length; i++) {
      if (article.title == _savedArticles[i].title) {
        _errorMessage = 'item saved error'.tr();
        databaseMessagesStates = DatabaseMessagesStates.Error;
        return;
      }
    }
    await _databaseHelper.insertArticle(article);
    _savedArticles.add(article);
    _successMessage = 'item saved'.tr();
    databaseMessagesStates = DatabaseMessagesStates.Success;
    notifyListeners();
  }

  Future<void> deleteSelectedArticle(Article article) async {
    await _databaseHelper.deleteArticle(article.publishedAt);
    _savedArticles.remove(article);
    notifyListeners();
  }
}
