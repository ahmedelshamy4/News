import 'package:flutter/material.dart';
import 'package:news/view_model/states.dart';
import 'package:provider/provider.dart';

import '../../../app_components.dart';
import '../../../view_model/article_view_model.dart';
import '../components.dart';

class SportsTabView extends StatelessWidget {
  const SportsTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.sportsStates == SportsStates.InitialState) {
          provider.getSportsArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.sportsStates == SportsStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.sportsStates == SportsStates.LoadedState) {
          return buildTabViewBody(
            refreshKey: GlobalKey<RefreshIndicatorState>(),
            refresh: () {
              return provider.getSportsArticles(country: provider.language!);
            },
            articles: provider.sportsArticles!,
          );
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getSportsArticles(country: provider.language!);
            },
            image: provider.sportsErrorResult?.errorImage,
            errorMessage: provider.sportsErrorResult?.errorMessage,
          );
        }
      },
    );
  }
}
