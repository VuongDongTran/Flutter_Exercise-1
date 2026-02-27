class AppEnvironment {
  AppEnvironment._();

  static const String dev = 'dev';
  static const String uat = 'uat';
  static const String prod = 'prod';
}

class AppConstConfig {
  static const int pageSize = 20;
}

class ApiPath {
  ApiPath._();

  // Authenticate API
  static const String login = 'api/v1/account/login';
  static const String refreshToken = 'api/v1/account/refresh-token';

}

class UserSharedPreferencesPath {
  UserSharedPreferencesPath._();

  static const String token = 'userToken';
  static const String refreshToken = 'userRefreshToken';
  static const String tokenExpireAt = 'tokenExpireAt';
  static const String hasLogin = 'UserLogged';
  static const String username = 'username';
}

class InstanceResflul {
  InstanceResflul._();

  static const String instanceAuth = 'AppAuth';
  static const String instanceApp = 'AppInstance';
}

class WorkOrderItemStatus {
  static const String skip = 'SKIP';
  static const String finish = 'FINISHED';
  static const String unfinish = 'UNFINISHED';
}
