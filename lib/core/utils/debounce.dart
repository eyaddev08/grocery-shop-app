// أدوات مساعدة للبحث (Debounce)
import 'dart:async';

class Debounce {

  Debounce({required this.delay});
  final Duration delay;
  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

typedef VoidCallback = void Function();
