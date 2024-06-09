import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'API_KEY_DEV')
  static final String apiKeyDev = _Env.apiKeyDev;
  @EnviedField(varName: 'API_KEY_PROD')
  static final String apiKeyProd = _Env.apiKeyProd;
  @EnviedField(varName: 'API_KEY_STG')
  static final String apiKeyStg = _Env.apiKeyStg;
  @EnviedField(varName: 'BASE_URL')
  static final String baseUrl = _Env.baseUrl;
}
