// lib/presentation/business_onboarding/views/business_logo_preview_io.dart
// Used on mobile/desktop when dart:io is available.
import 'dart:io';

import 'package:flutter/material.dart';

Widget buildBusinessLogoPreview(String path, double width, double height, double radius) {
  if (path.isEmpty) return const SizedBox.shrink();
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: Image.file(
      File(path),
      fit: BoxFit.cover,
      width: width,
      height: height,
    ),
  );
}
