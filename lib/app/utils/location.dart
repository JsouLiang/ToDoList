import 'package:flutter/services.dart';

abstract class Location {
  static const MethodChannel platform = const MethodChannel('todo_list.example.io/location');

  static Future<String> getCurrentLocation() {
    return platform.invokeMethod<String>('getCurrentLocation');
  }
}