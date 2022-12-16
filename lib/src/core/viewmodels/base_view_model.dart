import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:flutter/foundation.dart';

abstract class BaseViewModel with ChangeNotifier {
  ViewState _state = ViewState.Idle;

  ViewState get state => _state;

  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  @override
  void dispose();
}
