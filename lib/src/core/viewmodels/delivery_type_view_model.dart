import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/delivery_type.dart';
import 'package:ConsumerApp/src/core/services/delivery/i_delivery_types_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/order/i_order_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class DeliveryTypeViewModel extends BaseViewModel {
  DeliveryTypeViewModel(
    this._navigationService,
    this._deliveryTypesService,
    this._orderService,
  );
  final INavigationService _navigationService;
  final IDeliveryTypesService _deliveryTypesService;
  final IOrderService _orderService;
  List<DeliveryType> deliveryTypes;

  DeliveryType deliveryType;

  void setDeliveryType(DeliveryType selecteDeliveryType) {
    setState(ViewState.Busy);
    deliveryType = selecteDeliveryType;
    setState(ViewState.Idle);
  }

  Future<void> choosePaymentType(double total) async {
    await _navigationService.pushNamed(
      RoutePaths.choosePaymentType,
      navigationFlow: NavigationFlow.Default,
      arguments: total,
    );
  }

  Future<void> chooseDeliveryAddress(double total) async {
    await _navigationService.pushNamed(
      RoutePaths.addressPicker,
      navigationFlow: NavigationFlow.Default,
      arguments: total,
    );
  }

  Future<void> setDeliveryTypes() async {
    setState(ViewState.Busy);
    deliveryTypes = await _deliveryTypesService.getDeliveryTypes();
    setState(ViewState.Idle);
  }

  Future<void> continueCheckingOut(double total) async {
    _orderService.setDeliveryType(deliveryType);
    if (deliveryType.uniqueId == 1) {
      await chooseDeliveryAddress(total);
    } else if (deliveryType.uniqueId == 2) {
      await choosePaymentType(total);
    }
  }
}
