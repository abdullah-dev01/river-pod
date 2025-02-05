import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoHelper {
  TodoHelper._();

  static Future<void> initialise() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();
      
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
