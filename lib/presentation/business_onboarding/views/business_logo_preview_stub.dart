// lib/presentation/business_onboarding/views/business_logo_preview_stub.dart
// Used on web where dart:io is not available; path is typically a blob URL.
import 'package:flutter/material.dart';

Widget buildBusinessLogoPreview(String path, double width, double height, double radius) {
  if (path.isEmpty) return const SizedBox.shrink();
  if (path.startsWith('http') || path.startsWith('blob:')) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        path,
        fit: BoxFit.cover,
        width: width,
        height: height,
      ),
    );
  }
  return SizedBox(width: width, height: height, child: Icon(Icons.image, size: width * 0.5));
}
