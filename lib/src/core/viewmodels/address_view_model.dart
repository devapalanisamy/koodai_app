import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/services/address/i_address_service.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';

class AddressViewModel extends BaseViewModel {
  final IAddressService _addressService;
  final INavigationService _navigationService;
  final IAuthenticationService _authenticationService;

  AddressViewModel(this._addressService, this._navigationService,
      this._authenticationService);

  Address address;

  Future<void> edit() async {
    setState(ViewState.Busy);
    if (address.id != null) {
      await update();
    } else {
      await addNewAddress();
    }
    setState(ViewState.Idle);
  }

  Future<void> addNewAddress() async {
    try {
      final id = await _authenticationService.getAccountId();
      address.userAccountId = id;
      final result = await _addressService.addAddress(address);
      if (result)
        _navigationService.pop(navigationFlow: NavigationFlow.Default);
    } catch (e) {
      print('something went wrong: $e');
    }
  }

  Future<void> update() async {
    try {
      final id = await _authenticationService.getAccountId();
      address.userAccountId = id;
      final result = await _addressService.updateAddress(address);
      if (result)
        _navigationService.pop(navigationFlow: NavigationFlow.Default);
    } catch (e) {
      print('something went wrong: $e');
    }
  }
}
