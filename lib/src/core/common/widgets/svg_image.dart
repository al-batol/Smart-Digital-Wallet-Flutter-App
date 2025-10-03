import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String path;
  final int? width;
  final int? height;
  final BoxFit? fit;

  const SvgImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(path, fit: fit ?? BoxFit.cover);
  }
}
