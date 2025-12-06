import 'package:flutter_svg/flutter_svg.dart';

class SvgCacheHelper {
  static final Map<String, bool> _cachedAssets = {};

  static Future<void> preCacheSvg(String assetPath) async {
    if (_cachedAssets[assetPath] == true) return;

    try {
      var loader = SvgAssetLoader(assetPath);
      await svg.cache.putIfAbsent(
        loader.cacheKey(null),
        () => loader.loadBytes(null),
      );
      _cachedAssets[assetPath] = true;
    } catch (e) {
      print('Failed to cache SVG: $assetPath, Error: $e');
    }
  }

  static Future<void> preCacheAllAssets(List<String> assetPaths) async {
    await Future.wait(assetPaths.map((path) => preCacheSvg(path)));
  }
}
