import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:flutter/foundation.dart';

abstract class IDialogService {
  Future<T> showAlert<T>({@required AlertType alertType});
  Future<T> showDefaultAlert<T>({
    String title,
    String message,
    String buttonTitle,
  });
  Future<void> showProgressIndicator();
  void hideProgressIndicator();
  Future<void> showNoConnectionBottomsheet();
}
