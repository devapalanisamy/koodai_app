import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/services/address/i_address_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/base_view_model.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';

class AddressListViewModel extends BaseViewModel {
  final IAddressService _addressService;
  final INavigationService _navigationService;
  AddressListViewModel(this._addressService, this._navigationService);

  List<Address> addresses;

  Future<void> setListOfAddresses() async {
    setState(ViewState.Busy);
    addresses = await _addressService.getAddresses();
    setState(ViewState.Idle);
  }

  Future<void> editAddress(Address address) async {
    setState(ViewState.Busy);
    await _navigationService.pushNamed(RoutePaths.address,
        navigationFlow: NavigationFlow.Default, arguments: address);
    setState(ViewState.Idle);
  }

  Future<void> deleteAddress(Address address) async {
    setState(ViewState.Busy);
    final isDeleted = await _addressService.deleteAddress(address);
    if (isDeleted) addresses = await _addressService.getAddresses();
    setState(ViewState.Idle);
  }

  Future<void> addAddress() async {
    setState(ViewState.Busy);
    await _navigationService.pushNamed(RoutePaths.address,
        navigationFlow: NavigationFlow.Default, arguments: null);
    addresses = await _addressService.getAddresses();
    setState(ViewState.Idle);
  }
}
