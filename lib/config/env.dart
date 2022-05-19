import 'package:flutter/material.dart';

enum BuildFlavor { production, development, staging }

class FlavorValue {
  final String baseUrl;

  FlavorValue({required this.baseUrl});
}

class FlavorConfig {
  factory FlavorConfig({
    required BuildFlavor flavor,
    required Color color,
    required FlavorValue flavorValue,
  }) {
    _instance = FlavorConfig._internal(flavor,color, flavorValue);
    return _instance;
  }

  FlavorConfig._internal(this.flavor,this.color, this.flavorValue);

  final BuildFlavor flavor;
  final FlavorValue flavorValue;
  final Color color;

  static late FlavorConfig _instance;

  static FlavorConfig get instance => _instance;
}
