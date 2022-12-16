import 'package:ConsumerApp/src/core/configs/api_paths.dart';
import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/extensions/http_extensions.dart';
import 'package:ConsumerApp/src/core/services/address/i_address_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';

class AddressService extends IAddressService {
  final IRestClient _restClient;

  AddressService(
    this._restClient,
  );
  @override
  Future<bool> addAddress(Address address) async {
    final response = await _restClient.post(
        ApiPaths.userAddress, addressToJson(address),
        isAuthenticationRequired: true);
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<bool> updateAddress(Address address) async {
    final response = await _restClient.put(
        ApiPaths.userAddress, addressToJson(address),
        isAuthenticationRequired: true);
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<List<Address>> getAddresses() async {
    final response = await _restClient.get(ApiPaths.userAddress,
        isAuthenticationRequired: true);
    if (response.success) {
      return addressesFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }

  @override
  Future<bool> deleteAddress(Address address) async {
    final path = ApiPaths.userAddress + '/' + address.id;
    final response =
        await _restClient.delete(path, isAuthenticationRequired: true);
    if (response.success) {
      return true;
    }
    throw Exception(response.reasonPhrase);
  }
}
