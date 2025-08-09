import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'shimmer_placeholder.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;
  final File? localFile;
  final double? radius;
  final Widget? errorWidget;
  final BoxFit? fit;

  const ImageView(
      {super.key,
      required this.imageUrl,
      this.radius,
      this.localFile,
      this.errorWidget,
      this.fit});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return imageProviderForWeb();
    } else {
      return imageProviderForMobile(context);
    }
  }

  Widget imageProviderForWeb() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
      child: Image.network(
        imageUrl,
        fit: fit ?? BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return CustomShimmer.squarer();
        },
      ),
    );
  }

  Widget imageProviderForMobile(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius ?? 0)),
      child: localFile != null
          ? Image.file(localFile!, fit: fit ?? BoxFit.cover)
          : CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit ?? BoxFit.cover,
              placeholder: (context, url) => CustomShimmer.squarer(),
              errorWidget: (context, url, error) =>
                  errorWidget ?? Image.asset('assets/images/logo.png'),
            ),
    );
  }

  Widget errorPlaceholder(BuildContext context) {
    return SvgPicture.asset('assets/images/rating.svg');
  }
}
