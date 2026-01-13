import 'dart:async';
import 'package:flutter/foundation.dart';

class StreamListener extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  StreamListener(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
