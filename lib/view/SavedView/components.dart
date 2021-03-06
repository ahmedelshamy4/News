import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:news/view/WebScreenView/web_screen.dart';
import 'package:news/view_model/database_view_model.dart';
import 'package:provider/provider.dart';

import '../../app_components.dart';
import '../../model/article.dart';
import '../../utils/colors.dart';
import '../../utils/helper/app_components.dart';
import '../../utils/helper/cache_helper.dart';

class BuildListOfSavedItem extends StatelessWidget {
  final List<Article> articles;

  const BuildListOfSavedItem({Key? key, required this.articles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: articles.length,
      separatorBuilder: (_, index) => const Divider(
        color: appMainColor,
      ),
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(
              start: 20.0, end: 20.0, top: 15.0),
          child: BuildItemOfSavedList(
            article: articles[index],
            onDismiss: (DismissDirection direction) {
              context
                  .read<DatabaseViewModel>()
                  .deleteSelectedArticle(articles[index]);
              toastMessage(message: 'item deleted'.tr());
            },
          ),
        );
      },
    );
  }
}

class BuildItemOfSavedList extends StatelessWidget {
  final Article article;
  final DismissDirectionCallback? onDismiss;

  const BuildItemOfSavedList(
      {Key? key, required this.article, required this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        materialNavigator(context, WebScreenView(article: article));
      },
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: onDismiss,
        background: buildDirectionDismissibleBackground(
          context,
          alignment: translator.activeLanguageCode == 'ar'
              ? Alignment.centerRight
              : Alignment.centerLeft,
          startPadding: 25.0,
          endPadding: 0.0,
        ),
        secondaryBackground: buildDirectionDismissibleBackground(
          context,
          alignment: translator.activeLanguageCode == 'ar'
              ? Alignment.centerLeft
              : Alignment.centerRight,
          startPadding: 0.0,
          endPadding: 25.0,
        ),
        child: Container(
          height: 125.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          margin: const EdgeInsetsDirectional.only(bottom: 5.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 25.0,
                          width: CacheHelper.getStringData(
                                      key: sharedPrefsLanguageKey) ==
                                  'eg'
                              ? 90.0
                              : 100.0,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                appMainColor,
                                Color(0xFFFFB400),
                              ],
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              ConvertToTimeAgo.convertToTimeAgo(
                                DateTime.parse(article.publishedAt),
                              ),
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  fontSize: CacheHelper.getStringData(
                                              key: sharedPrefsLanguageKey) ==
                                          'eg'
                                      ? 15.0
                                      : 13.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Text(
                          article.title,
                          style: TextStyle(
                            color: Theme.of(context).tabBarTheme.labelColor,
                            fontSize: 18.0,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8.0),
                  ),
                  child: BuildNetworkImage(
                    height: 125.0,
                    width: 125.0,
                    imageUrl: article.imageUrl,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildDirectionDismissibleBackground(BuildContext context,
      {required AlignmentGeometry alignment,
      required double startPadding,
      required double endPadding}) {
    return Container(
      alignment: alignment,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(start: startPadding, end: endPadding),
        child: CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.redAccent,
          child: Icon(
            Icons.delete,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
      ),
    );
  }
}

class BuildNoSavedItem extends StatelessWidget {
  const BuildNoSavedItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalDistance(),
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
              child: Image.asset(
                'assets/images/no items.png',
                height: 300.0,
                width: 250.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Container(
              height: 50.0,
              width: 250.0,
              decoration: const BoxDecoration(
                color: appMainColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Center(
                child: Text(
                  'no item saved'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
