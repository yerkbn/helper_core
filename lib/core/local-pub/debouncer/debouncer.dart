import 'dart:async';
import 'dart:ui';

class Debouncer {
  Duration delay;
  Timer? timer;
  late VoidCallback callback;

  Debouncer({this.delay = const Duration(milliseconds: 500)});

  void debounce(VoidCallback callback) {
    this.callback = callback;

    cancel();
    timer = Timer(delay, flush);
  }

  void cancel() {
    if (timer != null) {
      timer!.cancel();
    }
  }

  void flush() {
    callback();
    cancel();
  }
}
