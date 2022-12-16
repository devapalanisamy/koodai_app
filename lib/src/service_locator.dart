import 'package:ConsumerApp/src/core/configs/app_config.dart';
import 'package:ConsumerApp/src/core/services/address/address_service.dart';
import 'package:ConsumerApp/src/core/services/address/i_address_service.dart';
import 'package:ConsumerApp/src/core/services/app_settings/app_settings_service.dart';
import 'package:ConsumerApp/src/core/services/app_settings/i_app_settings_service.dart';
import 'package:ConsumerApp/src/core/services/authentication/authentication_service.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/basket/basket_service.dart';
import 'package:ConsumerApp/src/core/services/basket/i_basket_service.dart';
import 'package:ConsumerApp/src/core/services/delivery/delivery_types_service.dart';
import 'package:ConsumerApp/src/core/services/delivery/i_delivery_types_service.dart';
import 'package:ConsumerApp/src/core/services/dialog/dialog_service.dart';
import 'package:ConsumerApp/src/core/services/dialog/i_dialog_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/navigation_service.dart';
import 'package:ConsumerApp/src/core/services/order/i_order_service.dart';
import 'package:ConsumerApp/src/core/services/order/order_service.dart';
import 'package:ConsumerApp/src/core/services/payment/i_payment_service.dart';
import 'package:ConsumerApp/src/core/services/payment/payment_service.dart';
import 'package:ConsumerApp/src/core/services/products/i_products_service.dart';
import 'package:ConsumerApp/src/core/services/products/products_service.dart';
import 'package:ConsumerApp/src/core/services/rest_client/i_rest_client.dart';
import 'package:ConsumerApp/src/core/services/rest_client/rest_client.dart';
import 'package:ConsumerApp/src/core/services/storage/i_storage_service.dart';
import 'package:ConsumerApp/src/core/services/storage/storage_service.dart';
import 'package:ConsumerApp/src/core/viewmodels/address_list_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/address_picker_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/address_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/basket_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/bottom_tab_bar_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/change_password_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/credit_card_form_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/delivery_type_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/forgot_password_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/home_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/menu_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/order_success_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/order_summary_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/payment_type_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/products_list_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/login_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/product_detail_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/more_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/profile_view_model.dart';
import 'package:ConsumerApp/src/core/viewmodels/register_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

final serviceLocator = GetIt.instance;

setupServiceLocator(AppConfig appConfig) {
  _registerServices(appConfig);
  _registerViewModels();
}

_registerServices(AppConfig appConfig) {
  serviceLocator.registerSingleton(appConfig);
  serviceLocator.registerLazySingleton<Client>(() => Client());
  serviceLocator
      .registerLazySingleton<INavigationService>(() => NavigationService());
  serviceLocator.registerLazySingleton<IProductsService>(
      () => ProductsService(serviceLocator<IRestClient>()));
  serviceLocator.registerLazySingleton<IRestClient>(() => RestClient(
        serviceLocator<Client>(),
        appConfig,
        serviceLocator<IStorageService>(),
      ));
  serviceLocator.registerLazySingleton<IBasketService>(() => BasketService());
  serviceLocator.registerLazySingleton<IAppSettingsService>(
      () => AppSettingsService(serviceLocator<IRestClient>()));
  serviceLocator.registerLazySingleton<IStorageService>(() => StorageService());
  serviceLocator.registerLazySingleton<IAuthenticationService>(() =>
      AuthenticationService(
          serviceLocator<IRestClient>(), serviceLocator<IStorageService>()));
  serviceLocator.registerLazySingleton<IAddressService>(
      () => AddressService(serviceLocator<IRestClient>()));
  serviceLocator.registerLazySingleton<IPaymentService>(() => PaymentService(
        serviceLocator<IRestClient>(),
        serviceLocator<IDialogService>(),
      ));
  serviceLocator.registerLazySingleton<IDeliveryTypesService>(
      () => DeliveryTypesService(serviceLocator<IRestClient>()));
  serviceLocator.registerLazySingleton<IOrderService>(() => OrderService(
        serviceLocator<IRestClient>(),
        serviceLocator<INavigationService>(),
      ));
  serviceLocator.registerLazySingleton<IDialogService>(() => DialogService());
}

_registerViewModels() {
  serviceLocator
      .registerFactory<ProductsListViewModel>(() => ProductsListViewModel(
            serviceLocator<IProductsService>(),
            serviceLocator<INavigationService>(),
            serviceLocator<IBasketService>(),
          ));
  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(serviceLocator<IAuthenticationService>(),
        serviceLocator<INavigationService>()),
  );
  serviceLocator.registerFactory<DeliveryTypeViewModel>(
    () => DeliveryTypeViewModel(
      serviceLocator<INavigationService>(),
      serviceLocator<IDeliveryTypesService>(),
      serviceLocator<IOrderService>(),
    ),
  );
  serviceLocator.registerFactory<PaymentModeViewModel>(
    () => PaymentModeViewModel(
      serviceLocator<IPaymentService>(),
      serviceLocator<IOrderService>(),
      serviceLocator<INavigationService>(),
    ),
  );
  serviceLocator.registerFactory<AddressPickerViewModel>(
    () => AddressPickerViewModel(
      serviceLocator<INavigationService>(),
      serviceLocator<IAddressService>(),
      serviceLocator<IOrderService>(),
    ),
  );
  serviceLocator.registerFactory<BottomTabBarViewModel>(
      () => BottomTabBarViewModel(serviceLocator<IBasketService>()));
  serviceLocator.registerFactory<MoreViewModel>(() => MoreViewModel(
        serviceLocator<INavigationService>(),
        serviceLocator<IStorageService>(),
        serviceLocator<IAuthenticationService>(),
      ));
  serviceLocator.registerFactory<BasketViewModel>(() => BasketViewModel(
        serviceLocator<INavigationService>(),
        serviceLocator<IBasketService>(),
        serviceLocator<IOrderService>(),
      ));
  serviceLocator.registerFactory<ProductDetailViewModel>(
      () => ProductDetailViewModel(serviceLocator<IBasketService>()));
  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(serviceLocator<IAuthenticationService>(),
        serviceLocator<INavigationService>()),
  );
  serviceLocator.registerFactory<ForgotPasswordViewModel>(
    () => ForgotPasswordViewModel(serviceLocator<IAuthenticationService>(),
        serviceLocator<INavigationService>()),
  );
  serviceLocator.registerFactory<MenuViewModel>(
    () => MenuViewModel(
      serviceLocator<IProductsService>(),
      serviceLocator<INavigationService>(),
    ),
  );
  serviceLocator.registerFactory<HomeViewModel>(
    () => HomeViewModel(
      serviceLocator<IAppSettingsService>(),
      serviceLocator<IProductsService>(),
      serviceLocator<INavigationService>(),
      serviceLocator<IBasketService>(),
    ),
  );
  serviceLocator.registerFactory<AddressViewModel>(
    () => AddressViewModel(
      serviceLocator<IAddressService>(),
      serviceLocator<INavigationService>(),
      serviceLocator<IAuthenticationService>(),
    ),
  );
  serviceLocator.registerFactory<AddressListViewModel>(
    () => AddressListViewModel(
      serviceLocator<IAddressService>(),
      serviceLocator<INavigationService>(),
    ),
  );

  serviceLocator.registerFactory<ProfileViewModel>(
    () => ProfileViewModel(
      serviceLocator<IAuthenticationService>(),
      serviceLocator<INavigationService>(),
    ),
  );
  serviceLocator.registerFactory<ChangePasswordViewModel>(
    () => ChangePasswordViewModel(
      serviceLocator<INavigationService>(),
      serviceLocator<IAuthenticationService>(),
    ),
  );
  serviceLocator.registerFactory<OrderSummaryViewModel>(
    () => OrderSummaryViewModel(
      serviceLocator<IOrderService>(),
      serviceLocator<INavigationService>(),
      serviceLocator<IBasketService>(),
    ),
  );
  serviceLocator.registerFactory(
    () => OrderSuccessViewModel(
      serviceLocator<INavigationService>(),
    ),
  );
  serviceLocator.registerFactory(() => CreditCardFormViewModel(
        serviceLocator<IPaymentService>(),
        serviceLocator<INavigationService>(),
      ));
}
