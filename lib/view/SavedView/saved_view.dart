import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:news/view_model/database_states.dart';
import 'package:news/view_model/database_view_model.dart';
import 'package:provider/provider.dart';

import '../../app_components.dart';
import 'components.dart';

class SavedView extends StatelessWidget {
  const SavedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(title: 'saved articles'.tr()),
      body: Consumer<DatabaseViewModel>(
        builder: (context, provider, child) {
          if (provider.databaseStates == DatabaseStates.InitialState) {
            provider.getSavedArticlesFromDatabase();
            return Container(
              color: Colors.transparent,
            );
          } else {
            return provider.savedArticles.isNotEmpty
                ? BuildListOfSavedItem(articles: provider.savedArticles)
                : BuildNoSavedItem();
          }
        },
      ),
    );
  }
}
