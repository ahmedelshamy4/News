import 'package:flutter/material.dart';
import 'package:news/view_model/states.dart';
import 'package:provider/provider.dart';

import '../../../app_components.dart';
import '../../../view_model/article_view_model.dart';
import '../components.dart';

class TechTabView extends StatelessWidget {
  const TechTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.techStates == TechStates.InitialState) {
          provider.getTechArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.techStates == TechStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.techStates == TechStates.LoadedState) {
          return buildTabViewBody(
            refreshKey: GlobalKey<RefreshIndicatorState>(),
            refresh: () {
              return provider.getTechArticles(country: provider.language!);
            },
            articles: provider.techArticles!,
          );
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getTechArticles(country: provider.language!);
            },
            image: provider.techErrorResult?.errorImage,
            errorMessage: provider.techErrorResult?.errorMessage,
          );
        }
      },
    );
  }
}
