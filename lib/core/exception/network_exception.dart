import 'package:helper_core/core/exception/parent_exception.dart';

/// Network, System Exceptions start from 1000

class NetworkFailureExcD extends ExceptionData {
  static const int status = 1001;
  static const String desc = 'Network failure';

  NetworkFailureExcD({super.objectMap})
      : super(status: status, description: desc);

  factory NetworkFailureExcD.parseMap(Map objectMap) {
    return NetworkFailureExcD(objectMap: objectMap);
  }
}

class UnauthenticatedExcD extends ExceptionData {
  static const int status = 1002;
  static const String desc =
      'Unauthenticated, try to access to senssitive data';

  UnauthenticatedExcD({super.objectMap})
      : super(status: status, description: desc);

  factory UnauthenticatedExcD.parseMap(Map objectMap) {
    return UnauthenticatedExcD(objectMap: objectMap);
  }
}

/// FROM SERVER

class BadRequestExcD extends ExceptionData {
  static const int status = 2001;
  static const String desc = 'Request was incorrect';

  BadRequestExcD({super.objectMap}) : super(status: status, description: desc);

  factory BadRequestExcD.parseMap(Map objectMap) {
    return BadRequestExcD(objectMap: objectMap);
  }
}

class NotFoundExcD extends ExceptionData {
  static const int status = 2002;
  static const String desc = 'Requested item not found';

  NotFoundExcD({super.objectMap}) : super(status: status, description: desc);

  factory NotFoundExcD.parseMap(Map objectMap) {
    return NotFoundExcD(objectMap: objectMap);
  }
}

class TokenExpiredExcD extends ExceptionData {
  static const int status = 2004;
  static const String desc = 'Token expired we need to refresh token';

  TokenExpiredExcD({super.objectMap})
      : super(status: status, description: desc);

  factory TokenExpiredExcD.parseMap(Map objectMap) {
    return TokenExpiredExcD(objectMap: objectMap);
  }
}

class UsernameIsTakenExcD extends ExceptionData {
  static const int status = 2005;
  static const String desc = 'Username already taken';

  UsernameIsTakenExcD({super.objectMap})
      : super(status: status, description: desc);

  factory UsernameIsTakenExcD.parseMap(Map objectMap) {
    return UsernameIsTakenExcD(objectMap: objectMap);
  }
}

class SubscriptionExpiredExcD extends ExceptionData {
  static const int status = 2006;
  static const String desc = 'Subscription expired';
  SubscriptionExpiredExcD({super.objectMap})
      : super(status: status, description: desc);
  factory SubscriptionExpiredExcD.parseMap(Map objectMap) {
    return SubscriptionExpiredExcD(objectMap: objectMap);
  }
}

class SignupFirstExcD extends ExceptionData {
  static const int status = 2007;
  static const String desc = 'You need to sign up first';

  SignupFirstExcD({super.objectMap}) : super(status: status, description: desc);

  factory SignupFirstExcD.parseMap(Map objectMap) {
    return SignupFirstExcD(objectMap: objectMap);
  }
}

class IncorectCredentialsExcD extends ExceptionData {
  static const int status = 2008;
  static const String desc = 'Email or Password Incorrect';

  IncorectCredentialsExcD({super.objectMap})
      : super(status: status, description: desc);

  factory IncorectCredentialsExcD.parseMap(Map objectMap) {
    return IncorectCredentialsExcD(objectMap: objectMap);
  }
}

class EmailTakenExcD extends ExceptionData {
  static const int status = 2009;
  static const String desc = 'Email is taken!';

  EmailTakenExcD({super.objectMap}) : super(status: status, description: desc);

  factory EmailTakenExcD.parseMap(Map objectMap) {
    return EmailTakenExcD(objectMap: objectMap);
  }
}
