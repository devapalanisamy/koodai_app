import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/payment_mode.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/order/i_order_service.dart';
import 'package:ConsumerApp/src/core/services/payment/i_payment_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class PaymentModeViewModel extends BaseViewModel {
  List<PaymentMode> paymentModes;

  final IPaymentService _paymentService;
  final IOrderService _orderService;
  final INavigationService _navigationService;

  PaymentMode selectedPaymentMode;

  PaymentModeViewModel(
    this._paymentService,
    this._orderService,
    this._navigationService,
  );

  void setPaymentType(PaymentMode paymentMode) {
    setState(ViewState.Busy);
    selectedPaymentMode = paymentMode;
    setState(ViewState.Idle);
  }

  Future<void> setPaymentModes() async {
    setState(ViewState.Busy);
    paymentModes = await _paymentService.getPaymentMethods();
    setState(ViewState.Idle);
  }

  Future<void> showNextView() async {
    _orderService.setPaymentMethod(selectedPaymentMode);
    if (selectedPaymentMode.uniqueId == 0 ||
        selectedPaymentMode.uniqueId == 1) {
      await _navigationService.pushNamed(RoutePaths.creditCardForm,
          navigationFlow: NavigationFlow.Default);
    }
  }
}
