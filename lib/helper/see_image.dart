import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_agri_farmers/helper/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
dynamic prev;
class SeeImage extends StatelessWidget {

  const SeeImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     prev =ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBarHelper.getSimpleAppBar(context: context, name: "Quality Certificate"),
      body: Center(
        child: showImage(),
      )
    );
  }

  showImage() {
    return CachedNetworkImage(
      imageUrl: prev["url"],
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
