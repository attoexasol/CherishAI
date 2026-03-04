// lib/presentation/business_onboarding/views/business_logo_preview.dart
// Conditional import: use io (Image.file) on mobile/desktop, stub (Image.network/placeholder) on web.
import 'package:flutter/material.dart';
import 'business_logo_preview_stub.dart' if (dart.library.io) 'business_logo_preview_io.dart' as impl;

Widget buildBusinessLogoPreview(String path, double width, double height, double radius) {
  return impl.buildBusinessLogoPreview(path, width, height, radius);
}
