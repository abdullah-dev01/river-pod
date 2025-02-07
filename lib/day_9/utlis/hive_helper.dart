import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveHelper {
  HiveHelper._(); // Private constructor to prevent instantiation

  /// Initialize Hive and open required boxes
  static Future<void> initialize() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      final directory = await getApplicationDocumentsDirectory();
      Hive.init(directory.path);
      await Hive.initFlutter();
    } catch (e) {
      debugPrint('Error initializing Hive: $e');
    }
  }

  /// Open a box if not already open
  static Future<void> openBox<T>(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);
    }
  }

  /// Get an already opened box
  static Box<T>? getBox<T>(String boxName) {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    } else {
      debugPrint("Hive box '$boxName' is not open.");
      return null;
    }
  }

  /// Add or update an item in the box
  static Future<void> addOrUpdateItem<T>(
    String boxName,
    dynamic key,
    T value,
  ) async {
    final box = getBox<T>(boxName);
    if (box != null) {
      await box.put(key, value);
    } else {
      await openBox<T>(boxName);
      final newBox = getBox<T>(boxName);
      await newBox?.put(key, value);
    }
  }

  /// Delete an item from the box
  static Future<void> deleteItem<T>(String boxName, dynamic key) async {
    final box = getBox<T>(boxName);
    if (box != null && box.containsKey(key)) {
      await box.delete(key);
    } else {
      debugPrint(
          "Cannot delete: Item with key '$key' not found in box '$boxName'.");
    }
  }

  /// Retrieve all items from a box
  static List<T> getAllItems<T>(String boxName) {
    final box = getBox<T>(boxName);
    return box?.values.toList() ?? [];
  }

  /// Retrieve an item from a box
  static Future<T?> getTask<T>(String id) async {
    final box = getBox<T>('tasks');
    return box?.get(id);
  }
}
