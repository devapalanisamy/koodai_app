import 'package:ConsumerApp/src/core/models/address.dart';

abstract class IAddressService {
  Future<bool> addAddress(Address address);
  Future<bool> updateAddress(Address address);
  Future<bool> deleteAddress(Address address);
  Future<List<Address>> getAddresses();
}
