/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart' as _svg;
import 'package:vector_graphics/vector_graphics.dart' as _vg;

class $ImageGen {
  const $ImageGen();

  /// File path: image/busness_state_architecture.png
  AssetGenImage get busnessStateArchitecture =>
      const AssetGenImage('image/busness_state_architecture.png');

  /// File path: image/gif1.gif
  AssetGenImage get gif1 => const AssetGenImage('image/gif1.gif');

  /// List of all assets
  List<AssetGenImage> get values => [busnessStateArchitecture, gif1];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// Directory path: assets/images/onboarding
  $AssetsImagesOnboardingGen get onboarding =>
      const $AssetsImagesOnboardingGen();

  /// Directory path: assets/images/splash
  $AssetsImagesSplashGen get splash => const $AssetsImagesSplashGen();
}

class $AssetsImagesOnboardingGen {
  const $AssetsImagesOnboardingGen();

  /// File path: assets/images/onboarding/empty_state.svg
  SvgGenImage get emptyState =>
      const SvgGenImage('assets/images/onboarding/empty_state.svg');

  /// File path: assets/images/onboarding/empty_state.svg.vec
  SvgGenImage get emptyStateSvg =>
      const SvgGenImage.vec('assets/images/onboarding/empty_state.svg.vec');

  /// File path: assets/images/onboarding/female.png
  AssetGenImage get female =>
      const AssetGenImage('assets/images/onboarding/female.png');

  /// File path: assets/images/onboarding/male.png
  AssetGenImage get male =>
      const AssetGenImage('assets/images/onboarding/male.png');

  /// File path: assets/images/onboarding/meals.svg
  SvgGenImage get meals =>
      const SvgGenImage('assets/images/onboarding/meals.svg');

  /// File path: assets/images/onboarding/meals.svg.vec
  SvgGenImage get mealsSvg =>
      const SvgGenImage.vec('assets/images/onboarding/meals.svg.vec');

  /// File path: assets/images/onboarding/workout.svg
  SvgGenImage get workout =>
      const SvgGenImage('assets/images/onboarding/workout.svg');

  /// File path: assets/images/onboarding/workout.svg.vec
  SvgGenImage get workoutSvg =>
      const SvgGenImage.vec('assets/images/onboarding/workout.svg.vec');

  /// List of all assets
  List<dynamic> get values => [
    emptyState,
    emptyStateSvg,
    female,
    male,
    meals,
    mealsSvg,
    workout,
    workoutSvg,
  ];
}

class $AssetsImagesSplashGen {
  const $AssetsImagesSplashGen();

  /// File path: assets/images/splash/lg_app_logo_12.png
  AssetGenImage get lgAppLogo12 =>
      const AssetGenImage('assets/images/splash/lg_app_logo_12.png');

  /// File path: assets/images/splash/wellness_logo.png
  AssetGenImage get wellnessLogo =>
      const AssetGenImage('assets/images/splash/wellness_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [lgAppLogo12, wellnessLogo];
}

class Assets {
  const Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $ImageGen image = $ImageGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName, {this.size, this.flavors = const {}});

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = false;

  const SvgGenImage.vec(this._assetName, {this.size, this.flavors = const {}})
    : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  _svg.SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    _svg.SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final _svg.BytesLoader loader;
    if (_isVecFormat) {
      loader = _vg.AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = _svg.SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return _svg.SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter:
          colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
