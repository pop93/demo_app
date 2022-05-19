enum BuildFlavor { production, development, staging }

class FlavorValue {
  final String baseUrl;

  FlavorValue({required this.baseUrl});
}

class FlavorConfig {
  factory FlavorConfig({
    required BuildFlavor flavor,
    required FlavorValue flavorValue,
  }) {
    _instance = FlavorConfig._internal(flavor, flavorValue);
    return _instance;
  }

  FlavorConfig._internal(this.flavor, this.flavorValue);

  final BuildFlavor flavor;
  final FlavorValue flavorValue;

  static late FlavorConfig _instance;

  static FlavorConfig get instance => _instance;
}
