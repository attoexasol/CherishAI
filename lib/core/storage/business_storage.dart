// lib/core/storage/business_storage.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class BusinessStorage {
  static const String _keyProducts = 'business_products';
  static const String _keyLocations = 'business_locations';

  /// Load products as raw Map list
  static Future<List<Map<String, dynamic>>> loadProductsRaw() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_keyProducts);
      if (jsonStr == null || jsonStr.isEmpty) {
        return [];
      }
      final decoded = jsonDecode(jsonStr) as List;
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Save products as raw Map list
  static Future<void> saveProductsRaw(List<Map<String, dynamic>> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = jsonEncode(items);
      await prefs.setString(_keyProducts, jsonStr);
    } catch (e) {
      // Handle error silently or log
    }
  }

  /// Load locations as raw Map list
  static Future<List<Map<String, dynamic>>> loadLocationsRaw() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = prefs.getString(_keyLocations);
      if (jsonStr == null || jsonStr.isEmpty) {
        return [];
      }
      final decoded = jsonDecode(jsonStr) as List;
      return decoded.cast<Map<String, dynamic>>();
    } catch (e) {
      return [];
    }
  }

  /// Save locations as raw Map list
  static Future<void> saveLocationsRaw(List<Map<String, dynamic>> items) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonStr = jsonEncode(items);
      await prefs.setString(_keyLocations, jsonStr);
    } catch (e) {
      // Handle error silently or log
    }
  }
}
