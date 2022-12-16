import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/services/address/i_address_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/order/i_order_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class AddressPickerViewModel extends BaseViewModel {
  final INavigationService _navigationService;
  final IAddressService _addressService;
  final IOrderService _orderService;
  List<Address> addresses;

  Address selectedAddress;

  AddressPickerViewModel(
    this._navigationService,
    this._addressService,
    this._orderService,
  );

  void setAddressId(Address address) {
    setState(ViewState.Busy);
    selectedAddress = address;
    setState(ViewState.Idle);
  }

  Future<void> choosePaymentType(double total) async {
    _orderService.setShippingAddress(selectedAddress);
    await _navigationService.pushNamed(
      RoutePaths.choosePaymentType,
      navigationFlow: NavigationFlow.Default,
      arguments: total,
    );
  }

  Future<void> setAddresses() async {
    setState(ViewState.Busy);
    addresses = await _addressService.getAddresses();
    setState(ViewState.Idle);
  }
}
