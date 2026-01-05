import 'dart:async';
import 'dart:ui';

class Debounce {
  final int millisecond;
  Timer? _timer;

  Debounce({required this.millisecond});

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: millisecond), action);
  }
}
