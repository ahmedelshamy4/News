import 'package:flutter/material.dart';
import 'package:news/view_model/states.dart';
import 'package:provider/provider.dart';

import '../../../app_components.dart';
import '../../../view_model/article_view_model.dart';
import '../components.dart';

class BusinessTabView extends StatelessWidget {
  const BusinessTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ArticleViewModel>(
      builder: (context, provider, child) {
        if (provider.businessStates == BusinessStates.InitialState) {
          provider.getBusinessArticles(country: provider.language!);
          return const BuildLoadingWidget();
        } else if (provider.businessStates == BusinessStates.LoadingState) {
          return const BuildLoadingWidget();
        } else if (provider.businessStates == BusinessStates.LoadedState) {
          return buildTabViewBody(
            refreshKey: GlobalKey<RefreshIndicatorState>(),
            refresh: () {
              return provider.getBusinessArticles(country: provider.language!);
            },
            articles: provider.businessArticles!,
          );
        } else {
          return BuildErrorWidget(
            refresh: () {
              return provider.getBusinessArticles(country: provider.language!);
            },
            image: provider.businessArticlesErrorResult?.errorImage,
            errorMessage: provider.businessArticlesErrorResult?.errorMessage,
          );
        }
      },
    );
  }
}
