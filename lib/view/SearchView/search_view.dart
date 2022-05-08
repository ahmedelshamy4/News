import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:news/view/SearchView/components.dart';
import 'package:news/view_model/article_view_model.dart';
import 'package:news/view_model/states.dart';
import 'package:provider/provider.dart';

import '../../app_components.dart';
import '../../utils/colors.dart';
import '../HomeView/components.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: 'searching for articles'.tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalDistance(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BuildTextFormField(
              changed: (String? value) {
                Provider.of<ArticleViewModel>(context, listen: false)
                    .getArticlesFromSearching(searchValue: value!);
              },
              controller: _controller,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(
              color: appGreyColor,
              thickness: 2.0,
            ),
          ),
          Consumer<ArticleViewModel>(
            builder: (context, provider, child) {
              if (provider.searchingStates == SearchingStates.InitialState) {
                return BuildSearchInitialWidget();
              } else if (provider.searchingStates ==
                  SearchingStates.LoadingState) {
                return const Expanded(
                  child: BuildLoadingWidget(),
                );
              } else if (provider.searchingStates ==
                  SearchingStates.LoadedState) {
                return Expanded(
                  child: ListView(
                    children: [
                      BuildListOfItem(
                        articlesNumber: 0,
                        articles: provider.searchArticles!,
                      ),
                    ],
                  ),
                );
              } else if (provider.searchingStates ==
                  SearchingStates.EmptyState) {
                return BuildSearchEmptyWidget();
              } else {
                return BuildSearchErrorWidget(
                  errorMessage: provider.searchErrorResult!.errorMessage,
                  image: provider.searchErrorResult!.errorImage,
                );
              }
            },
          )
        ],
      ),
    );
  }
}
