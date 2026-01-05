part of 'otp_verify_cubit.dart';

sealed class OtpVerifyState {
  const OtpVerifyState();
}

final class OtpVerifyInitial extends OtpVerifyState {
  const OtpVerifyInitial();
}

final class OtpVerifyLoading extends OtpVerifyState {
  const OtpVerifyLoading();
}

final class OtpVerifySuccess extends OtpVerifyState {
  final VerifyResponse verifyResult;
  const OtpVerifySuccess(this.verifyResult);
}

final class OtpVerifyError extends OtpVerifyState {
  final String? message;
  const OtpVerifyError(this.message);
}
