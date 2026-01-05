class AppError implements Exception {
  final String message;
  final String code;
  final AppErrorType type;

  AppError(this.message, this.code, this.type);
}

enum AppErrorType {
  otpTokenExpired,
  localAuthSpoiled,
  localAuthInvalidSession,
  userPermanentlyDisabled,
}

class UserTemporaryDisabled implements Exception {
  final DateTime? expiresAt;
  final String message;

  UserTemporaryDisabled({required this.expiresAt, required this.message});
}

class UserPermanentlyDisabled implements Exception {
  final String? message;

  UserPermanentlyDisabled({required this.message});
}

class RequestCancelled implements Exception {
  final String? message;

  RequestCancelled([this.message]);
}

class RetryException<T> implements Exception {
  final T? data;

  const RetryException({this.data});
}

class SessionExpiredException implements Exception {}

class UserBlockedException implements Exception {
  final String message;

  UserBlockedException(this.message);
}
