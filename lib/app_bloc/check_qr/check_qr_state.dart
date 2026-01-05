part of 'check_qr_cubit.dart';

sealed class CheckQrState {
  const CheckQrState();
}

final class CheckQrInitial extends CheckQrState {
  const CheckQrInitial();
}

final class CheckQrLoading extends CheckQrState {
  const CheckQrLoading();
}

final class CheckQrLoaded extends CheckQrState {
  final String success;
  const CheckQrLoaded(this.success);
}

final class CheckQrError extends CheckQrState {
  final String? message;
  const CheckQrError(this.message);
}
