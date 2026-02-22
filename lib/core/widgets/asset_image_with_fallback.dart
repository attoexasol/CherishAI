// lib/core/widgets/asset_image_with_fallback.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Displays an image from Flutter local assets. Never crashes: if the asset
/// is missing or fails to load/decode, [placeholder] is shown instead.
/// In debug mode, logs the failing asset path for easier debugging.
class AssetImageWithFallback extends StatefulWidget {
  const AssetImageWithFallback({
    super.key,
    required this.assetPath,
    required this.placeholder,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
    this.padding,
  });

  final String assetPath;
  final Widget placeholder;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final BorderRadius? borderRadius;
  final Color? color;
  final BlendMode? colorBlendMode;
  final EdgeInsetsGeometry? padding;

  @override
  State<AssetImageWithFallback> createState() => _AssetImageWithFallbackState();
}

class _AssetImageWithFallbackState extends State<AssetImageWithFallback> {
  bool _assetExists = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();
    _checkAsset();
  }

  @override
  void didUpdateWidget(AssetImageWithFallback oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _checked = false;
      _checkAsset();
    }
  }

  Future<void> _checkAsset() async {
    try {
      await rootBundle.load(widget.assetPath);
      if (mounted) {
        setState(() {
          _assetExists = true;
          _checked = true;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AssetImageWithFallback: asset missing or unreadable: ${widget.assetPath} ($e)');
      }
      if (mounted) {
        setState(() {
          _assetExists = false;
          _checked = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (!_checked || !_assetExists) {
      child = widget.placeholder;
    } else {
      child = Image.asset(
        widget.assetPath,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        alignment: widget.alignment,
        color: widget.color,
        colorBlendMode: widget.colorBlendMode ?? (widget.color != null ? BlendMode.srcIn : null),
        errorBuilder: (_, Object error, StackTrace? stackTrace) {
          if (kDebugMode) {
            debugPrint('AssetImageWithFallback: decode/load failed for ${widget.assetPath}: $error');
          }
          return widget.placeholder;
        },
      );
    }
    if (widget.borderRadius != null) {
      child = ClipRRect(
        borderRadius: widget.borderRadius!,
        child: child,
      );
    }
    if (widget.padding != null) {
      child = Padding(
        padding: widget.padding!,
        child: child,
      );
    }
    return child;
  }
}
