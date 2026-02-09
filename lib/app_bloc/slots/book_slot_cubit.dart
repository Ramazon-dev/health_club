import '../../data/network/provider/main_provider.dart';
import '../app_bloc.dart';

part 'book_slot_state.dart';

class BookSlotCubit extends Cubit<BookSlotState> {
  final MainProvider _mainProvider;

  BookSlotCubit(this._mainProvider) : super(BookSlotInitial());

  Future<void> reserveSlot(int reservationId) async {
    emit(BookSlotLoading());
    final res = await _mainProvider.bookSlot(reservationId);
    if (res.data != null) {
      emit(BookSlotLoaded());
    } else {
      emit(BookSlotError(res.message));
    }
  }

  Future<void> cancelReserve(int clientReservationId) async {
    emit(BookSlotLoading());
    final res = await _mainProvider.cancelBook(clientReservationId);
    if (res.data != null) {
      emit(BookSlotLoaded());
    } else {
      emit(BookSlotError(res.message));
    }
  }
}
