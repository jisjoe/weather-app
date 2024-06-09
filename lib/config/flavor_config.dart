import 'package:collection/collection.dart';
import 'package:weather_app/constants/env/env.dart';

enum Flavor {
  /// Flavor for development environment. Used for local development and debugging.
  dev,

  /// Flavor for production environment. The final release of your app.
  prod,

  /// Flavor for staging environment. Used for testing pre-production features.
  stg,
}

extension FlavorExtension on String {
  Flavor? toEnum() {
    return Flavor.values
        .firstWhereOrNull((flavor) => flavor.name == toLowerCase());
  }
}

class FlavorConfig {
  // Private constructor to prevent direct instantiation.
  FlavorConfig._internal();

  /// This value determines the configuration used by the app,
  /// such as API base URLs and potentially environment-specific behavior.
  ///
  /// **Set this before calling `runApp()`** to ensure the correct configuration is applied throughout the app.
  static Flavor? flavor;

  /// Open Weather API Key based on the current flavor.
  static String get apiKey {
    switch (flavor) {
      case Flavor.dev:
        return Env.apiKeyDev;
      case Flavor.stg:
        return Env.apiKeyStg;
      case Flavor.prod:
        return Env.apiKeyProd;
      case null:
        throw invalidFlavor;
    }
  }

  static final invalidFlavor = Exception('Invalid flavor: $flavor');
}
