import 'package:flutter/cupertino.dart';
import 'package:news/model/article.dart';
import 'package:news/view_model/states.dart';

import '../model/error_result.dart';
import '../services/remote_artical.dart';
import '../utils/helper/app_components.dart';
import '../utils/helper/cache_helper.dart';

class ArticleViewModel extends ChangeNotifier {
  String? cacheLang = CacheHelper.getStringData(key: sharedPrefsLanguageKey);

  late TopHeadlinesStates topHeadlinesStates;
  late BusinessStates businessStates;
  late TechStates techStates;
  late SportsStates sportsStates;
  late HealthStates healthStates;
  late EntertainmentStates entertainmentStates;
  late SearchingStates searchingStates;

  ///INITIALIZE STATES VALUE
  ArticleViewModel() {
    changeServiceLang(currentLang: cacheLang);
    topHeadlinesStates = TopHeadlinesStates.InitialState;
    businessStates = BusinessStates.InitialState;
    techStates = TechStates.InitialState;
    sportsStates = SportsStates.InitialState;
    healthStates = HealthStates.InitialState;
    entertainmentStates = EntertainmentStates.InitialState;
    searchingStates = SearchingStates.InitialState;
  }

  String? language;

  void changeServiceLang({String selectedLang = 'eg', String? currentLang}) {
    if (currentLang != null) {
      language = cacheLang!;
      notifyListeners();
    } else {
      language = selectedLang;
      CacheHelper.setStringData(key: sharedPrefsLanguageKey, value: language!);
      changeServicesStates();
      notifyListeners();
    }
  }

  void changeServicesStates() {
    topHeadlinesStates = TopHeadlinesStates.InitialState;
    businessStates = BusinessStates.InitialState;
    techStates = TechStates.InitialState;
    sportsStates = SportsStates.InitialState;
    healthStates = HealthStates.InitialState;
    entertainmentStates = EntertainmentStates.InitialState;
  }

  final ArticleServicesImplementation _articleServicesImplementation =
      ArticleServicesImplementation();

  List<Article>? _topHeadlinesArticles;
  List<Article>? _businessArticles;
  List<Article>? _techArticles;
  List<Article>? _sportsArticles;
  List<Article>? _healthArticles;
  List<Article>? _entertainmentArticles;
  List<Article>? _searchArticles;

  List<Article>? get topHeadlinesArticles => _topHeadlinesArticles;

  List<Article>? get businessArticles => _businessArticles;

  List<Article>? get techArticles => _techArticles;

  List<Article>? get sportsArticles => _sportsArticles;

  List<Article>? get healthArticles => _healthArticles;

  List<Article>? get entertainmentArticles => _entertainmentArticles;

  List<Article>? get searchArticles => _searchArticles;

  ErrorResult? _topHeadlineErrorResult;
  ErrorResult? _businessArticlesErrorResult;
  ErrorResult? _techErrorResult;
  ErrorResult? _sportsErrorResult;
  ErrorResult? _healthErrorResult;
  ErrorResult? _entertainmentErrorResult;
  ErrorResult? _searchErrorResult;

  ErrorResult? get searchErrorResult => _searchErrorResult;

  ErrorResult? get topHeadlineErrorResult => _topHeadlineErrorResult;

  ErrorResult? get businessArticlesErrorResult => _businessArticlesErrorResult;

  ErrorResult? get techErrorResult => _techErrorResult;

  ErrorResult? get sportsErrorResult => _sportsErrorResult;

  ErrorResult? get healthErrorResult => _healthErrorResult;

  ErrorResult? get entertainmentErrorResult => _entertainmentErrorResult;

  Future<void> getTopHeadlineArticles({required String country}) async {
    topHeadlinesStates = TopHeadlinesStates.LoadingState;
    await _articleServicesImplementation
        .getTopHeadlineArticles(country: country)
        .then(
      (value) {
        value.fold(
          (left) {
            _topHeadlinesArticles = left;
            topHeadlinesStates = TopHeadlinesStates.LoadedState;
          },
          (right) {
            _topHeadlineErrorResult = right;
            topHeadlinesStates = TopHeadlinesStates.ErrorState;
          },
        );
      },
    );
    notifyListeners();
  }

  Future<void> getBusinessArticles({required String country}) async {
    businessStates = BusinessStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'business')
        .then(
      (value) {
        value.fold(
          (left) {
            _businessArticles = left;
            businessStates = BusinessStates.LoadedState;
          },
          (right) {
            _businessArticlesErrorResult = right;
            businessStates = BusinessStates.ErrorState;
          },
        );
      },
    );
    notifyListeners();
  }

  Future<void> getTechArticles({required String country}) async {
    techStates = TechStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'technology')
        .then(
      (value) {
        value.fold(
          (left) {
            _techArticles = left;
            techStates = TechStates.LoadedState;
          },
          (right) {
            _techErrorResult = right;
            techStates = TechStates.ErrorState;
          },
        );
      },
    );
    notifyListeners();
  }

  Future<void> getSportsArticles({required String country}) async {
    sportsStates = SportsStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'sports')
        .then(
      (value) {
        value.fold(
          (left) {
            _sportsArticles = left;
            sportsStates = SportsStates.LoadedState;
          },
          (right) {
            _sportsErrorResult = right;
            sportsStates = SportsStates.ErrorState;
          },
        );
      },
    );
    notifyListeners();
  }

  Future<void> getHealthArticles({required String country}) async {
    healthStates = HealthStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'health')
        .then(
      (value) {
        value.fold(
          (left) {
            _healthArticles = left;
            healthStates = HealthStates.LoadedState;
          },
          (right) {
            _healthErrorResult = right;
            healthStates = HealthStates.ErrorState;
          },
        );
      },
    );
    notifyListeners();
  }

  Future<void> getEntertainmentArticles({required String country}) async {
    entertainmentStates = EntertainmentStates.LoadingState;
    await _articleServicesImplementation
        .getArticlesByCategory(country: country, category: 'entertainment')
        .then((value) {
      value.fold((left) {
        _entertainmentArticles = left;
        entertainmentStates = EntertainmentStates.LoadedState;
      }, (right) {
        _entertainmentErrorResult = right;
        entertainmentStates = EntertainmentStates.ErrorState;
      });
    });
    notifyListeners();
  }

  Future<void> getArticlesFromSearching({required String searchValue}) async {
    searchingStates = SearchingStates.LoadingState;
    notifyListeners();
    if (searchValue.isNotEmpty) {
      await _articleServicesImplementation
          .getArticlesFromSearch(searchValue: searchValue)
          .then(
        (value) {
          value.fold((left) {
            _searchArticles = left;
            searchingStates = SearchingStates.LoadedState;
          }, (right) {
            _entertainmentErrorResult = right;
            searchingStates = SearchingStates.ErrorState;
          });
        },
      );
    } else {
      searchingStates = SearchingStates.EmptyState;
    }
    notifyListeners();
  }
}
