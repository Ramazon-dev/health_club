part of 'book_slot_cubit.dart';

sealed class BookSlotState {
  const BookSlotState();
}

final class BookSlotInitial extends BookSlotState {
  const BookSlotInitial();
}

final class BookSlotLoading extends BookSlotState {
  const BookSlotLoading();
}

final class BookSlotLoaded extends BookSlotState {
  const BookSlotLoaded();
}

final class BookSlotError extends BookSlotState {
  final String? message;
  const BookSlotError(this.message);
}
