import 'package:ConsumerApp/src/core/models/delivery_type.dart';

abstract class IDeliveryTypesService {
  Future<List<DeliveryType>> getDeliveryTypes();
}
