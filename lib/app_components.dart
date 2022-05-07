import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:transparent_image/transparent_image.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Gradient gradient;

  const GradientText(
    this.text, {
    Key? key,
    required this.gradient,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

void materialNavigator(BuildContext context, Widget screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

void namedNavigator(BuildContext context, String routeName) =>
    Navigator.pushNamed(context, routeName);

///CUSTOM LOADING WIDGET
class BuildLoadingWidget extends StatelessWidget {
  const BuildLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

SizedBox verticalDistance() {
  return const SizedBox(
    height: 15.0,
  );
}

///BUILD CACHED NETWORK IMAGE CUSTOM WIDGET
class BuildNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height, width;

  const BuildNetworkImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Image.asset(
                'assets/images/loading.png',
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),
        FadeInImage.memoryNetwork(
          height: height,
          width: width,
          fit: BoxFit.fill,
          placeholder: kTransparentImage,
          image: imageUrl,
          placeholderErrorBuilder: (_, value, error) {
            return SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: Icon(
                  Icons.error,
                  size: 28.0,
                  color: Colors.red,
                ),
              ),
            );
          },
          imageErrorBuilder: (_, value, error) {
            return SizedBox(
              width: width,
              height: height,
              child: const Center(
                child: Icon(
                  Icons.error,
                  size: 28.0,
                  color: Colors.red,
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

///THIS CLASS CONVERTING DATE FROM STRING FORMAT TO TIME AGO
class ConvertToTimeAgo {
  static String convertToTimeAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inDays} ${('day').tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inDays} ${'day'.tr()}';
    } else if (diff.inHours == 2 || diff.inHours <= 10) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hours'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hours'.tr()}';
    } else if (diff.inHours == 1 || diff.inHours >= 11) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inHours} ${'hour'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inHours} ${'hour'.tr()}';
    } else if (diff.inMinutes >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inMinutes} ${'minute'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inMinutes} ${'minute'.tr()}';
    } else if (diff.inSeconds >= 1) {
      return translator.activeLanguageCode == 'en'
          ? '${diff.inSeconds} ${'second'.tr()} ${'ago'.tr()}'
          : '${'ago'.tr()} ${diff.inSeconds} ${'second'.tr()}';
    } else {
      return 'just now'.tr();
    }
  }
}

void toastMessage({required String message}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.black87.withOpacity(0.5),
      fontSize: 16.0);
}
///THIS METHOD TO BUILD SHARED APPBAR
AppBar buildCustomAppBar({required String title}) {
  return AppBar(
    centerTitle: true,
    elevation: 5.0,
    title: Text(
      title,
      style: const TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}