import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/services/dialog/i_dialog_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogService extends IDialogService {
  @override
  Future<T> showAlert<T>({AlertType alertType}) async {
    return await Get.dialog(Container(), useRootNavigator: false);
  }

  @override
  Future<T> showDefaultAlert<T>(
      {String title, String message, String buttonTitle}) async {
    return await Get.defaultDialog(
      textCancel: buttonTitle ?? 'Ok',
      title: title ?? 'Info',
      middleText: message ?? 'This is a default message.',
    );
  }

  @override
  Future<void> showProgressIndicator() async {
    await Get.dialog(
      Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void hideProgressIndicator() {
    if (Get.isDialogOpen) Navigator.pop(Get.context);
  }

  @override
  Future<void> showNoConnectionBottomsheet() async {
    await Get.bottomSheet(
        Container(
          child: Icon(Icons.close),
        ),
        isScrollControlled: true,
        isDismissible: false,
        enableDrag: false);
  }
}
