import 'package:ConsumerApp/src/core/configs/api_paths.dart';
import 'package:ConsumerApp/src/core/extensions/http_extensions.dart';
import 'package:ConsumerApp/src/core/models/delivery_type.dart';
import 'package:ConsumerApp/src/core/services/delivery/i_delivery_types_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';

class DeliveryTypesService extends IDeliveryTypesService {
  final IRestClient _restClient;

  DeliveryTypesService(this._restClient);

  @override
  Future<List<DeliveryType>> getDeliveryTypes() async {
    final response = await _restClient.get(ApiPaths.deliveryTypes,
        isAuthenticationRequired: true);
    if (response.success) {
      return deliveryTypesFromJson(response.body);
    }
    throw Exception(response.reasonPhrase);
  }
}
