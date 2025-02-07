import 'package:flutter/material.dart';
import 'package:river_pod/day_9/utlis/hive_helper.dart';

class TodoHelper {
  TodoHelper._();

  static Future<void> initialise() async {
    try {
      HiveHelper.initialize();
      // Hive.registerAdapter(TaskModelAdapter());
      // await Hive.openBox<TaskModel>('tasks');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
