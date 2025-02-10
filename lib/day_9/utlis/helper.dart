import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:river_pod/day_9/model/task_model.dart';
import 'dart:math';
import 'package:riverpod/riverpod.dart';
import 'package:intl/intl.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

class TodoHelper {
  TodoHelper._();

  static Future<void> initialise() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Hive.initFlutter();

      // Register Adapters
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(TaskModelAdapter());
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}

// 📌 Global Provider for DateFormatter
final dateFormatterProvider = Provider<DateFormat>((ref) {
  return DateFormat('MMMEd'); // Example: "Feb 5, 2025"
});

// 📌 Global Provider for Currency Formatter
final currencyFormatterProvider = Provider<NumberFormat>((ref) {
  return NumberFormat.currency(locale: 'en_US', symbol: '\$');
});

// 📌 Helper Class for Common Utilities
class AppHelper {
  /// ✅ Format Date
  static String formatDate(DateTime date, DateFormat formatter) {
    return formatter.format(date);
  }

  /// ✅ Format Currency
  static String formatCurrency(double amount, NumberFormat formatter) {
    return formatter.format(amount);
  }

  /// ✅ Time Ago Formatter
  static String timeAgo(DateTime date) {
    final Duration diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return "${diff.inSeconds} sec ago";
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hrs ago";
    if (diff.inDays < 7) return "${diff.inDays} days ago";
    return DateFormat.yMMMd().format(date);
  }

  /// ✅ Capitalize First Letter of a String
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// ✅ Validate Email
  static bool isValidEmail(String email) {
    final RegExp regex =
        RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
    return regex.hasMatch(email);
  }

  /// ✅ Format Phone Number (Simple Example)
  static String formatPhoneNumber(String phone) {
    if (phone.length == 10) {
      return "(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}";
    }
    return phone;
  }

  /// ✅ Generate Random String
  static String generateRandomString(int length) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
    ));
  }

  /// ✅ Debouncer (For Search Inputs)
  static void debounce(Function() action, {int milliseconds = 500}) {
    Future.delayed(Duration(milliseconds: milliseconds), action);
  }

  /// ✅ Check Internet Connectivity
  // static Future<bool> hasInternetConnection() async {
  //   var  connectivityResult= await Connectivity().checkConnectivity();
  //   return connectivityResult != ConnectivityResult.none;
  // }
}

// 📌 Riverpod Provider for Checking Internet Connection
// final connectivityProvider = FutureProvider<bool>((ref) async {
//   return await AppHelper.hasInternetConnection();
// });
