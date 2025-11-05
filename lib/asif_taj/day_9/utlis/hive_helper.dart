import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper<T> {
  final String boxName;
  Box<T>? _box;

  HiveHelper(this.boxName);

  /// Initializes Hive & opens the box
  Future<void> initialize() async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        _box = await Hive.openBox<T>(boxName);
        debugPrint('Box "$boxName" opened.');
      }
    } catch (e) {
      debugPrint('Error initializing box "$boxName": $e');
    }
  }

  /// Ensures the box is open before performing actions
  Future<void> _ensureBoxOpen() async {
    if (_box == null || !Hive.isBoxOpen(boxName)) {
      _box = await Hive.openBox<T>(boxName);
    }
  }

  /// Adds or updates an item with a specific key
  Future<void> addOrUpdateItem(dynamic key, T value) async {
    await _ensureBoxOpen();
    await _box?.put(key, value);
    debugPrint('Item added/updated in "$boxName" with key "$key".');
  }

  /// Retrieves all items in the box
  Future<List<T>> getAllItems() async {
    await _ensureBoxOpen();
    return _box?.values.toList() ?? [];
  }

  /// Retrieves an item by key
  Future<T?> getItem(dynamic key) async {
    await _ensureBoxOpen();
    return _box?.get(key);
  }

  /// Deletes an item by key
  Future<void> deleteItem(dynamic key) async {
    await _ensureBoxOpen();
    if (_box!.containsKey(key)) {
      await _box?.delete(key);
      debugPrint('Item deleted from "$boxName" with key "$key".');
    } else {
      debugPrint("Cannot delete: Item with key '$key' not found.");
    }
  }

  /// Clears all items from the box
  Future<void> clearAllItems() async {
    await _ensureBoxOpen();
    await _box?.clear();
    debugPrint('All items cleared from "$boxName".');
  }

  /// Closes the Hive box
  Future<void> closeBox() async {
    await _box?.close();
    debugPrint('Box "$boxName" closed.');
  }
}
