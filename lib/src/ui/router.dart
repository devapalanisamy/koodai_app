import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/models/menu.dart';
import 'package:ConsumerApp/src/core/models/product.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';
import 'package:ConsumerApp/src/ui/views/address_list_view.dart';
import 'package:ConsumerApp/src/ui/views/address_picker_view.dart';
import 'package:ConsumerApp/src/ui/views/address_view.dart';
import 'package:ConsumerApp/src/ui/views/bottom_tab_bar_view.dart';
import 'package:ConsumerApp/src/ui/views/change_password_view.dart';
import 'package:ConsumerApp/src/ui/views/credit_card_form_view.dart';
import 'package:ConsumerApp/src/ui/views/delivery_type_view.dart';
import 'package:ConsumerApp/src/ui/views/forgot_password_view.dart';
import 'package:ConsumerApp/src/ui/views/menu_view.dart';
import 'package:ConsumerApp/src/ui/views/order_success_view.dart';
import 'package:ConsumerApp/src/ui/views/order_summary_view.dart';
import 'package:ConsumerApp/src/ui/views/payment_type_view.dart';
import 'package:ConsumerApp/src/ui/views/products_list_view.dart';
import 'package:ConsumerApp/src/ui/views/login_view.dart';
import 'package:ConsumerApp/src/ui/views/product_detail_view.dart';
import 'package:ConsumerApp/src/ui/views/profile_view.dart';
import 'package:ConsumerApp/src/ui/views/register_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.menu:
        {
          final Tuple2<String, List<Menu>> arguments =
              settings.arguments as Tuple2<String, List<Menu>>;
          return CupertinoPageRoute<dynamic>(
              builder: (_) => MenuView(
                    title: arguments.item1,
                    menus: arguments.item2,
                  ));
        }

      case RoutePaths.address:
        {
          Address address;
          if (settings.arguments != null)
            address = settings.arguments as Address;
          return CupertinoPageRoute<dynamic>(
              builder: (_) => AddressView(
                    address: address,
                  ));
        }

      case RoutePaths.addressesList:
        return CupertinoPageRoute<dynamic>(builder: (_) => AddressListView());

      case RoutePaths.creditCardForm:
        return CupertinoPageRoute<dynamic>(
            builder: (_) => CreditCardFormView());

      case RoutePaths.changePassword:
        return CupertinoPageRoute<dynamic>(
            builder: (_) => ChangePasswordView());

      case RoutePaths.forgotPassword:
        return CupertinoPageRoute<dynamic>(
            builder: (_) => ForgotPasswordView());

      case RoutePaths.register:
        return CupertinoPageRoute<dynamic>(builder: (_) => RegisterView());

      case RoutePaths.orderSummary:
        return CupertinoPageRoute<dynamic>(builder: (_) => OrderSummaryView());

      case RoutePaths.orderSuccess:
        return CupertinoPageRoute<dynamic>(builder: (_) => OrderSuccessView());

      case RoutePaths.profile:
        return CupertinoPageRoute<dynamic>(builder: (_) => ProfileView());

      case RoutePaths.addressPicker:
        {
          final total = settings.arguments as double;
          return CupertinoPageRoute<dynamic>(
              builder: (_) => AddressPickerView(
                    total: total,
                  ));
        }

      case RoutePaths.chooseDeliveryType:
        {
          final total = settings.arguments as double;
          return CupertinoPageRoute<dynamic>(
              builder: (_) => DeliveryTypeView(
                    total: total,
                  ));
        }
      case RoutePaths.choosePaymentType:
        {
          final total = settings.arguments as double;
          return CupertinoPageRoute<dynamic>(
              builder: (_) => PaymentTypeView(
                    total: total,
                  ));
        }

      case RoutePaths.bottomTabBar:
        return CupertinoPageRoute<dynamic>(builder: (_) => BottomTabBarView());

      case RoutePaths.productsList:
        {
          final Tuple2<String, List<Product>> arguments =
              settings.arguments as Tuple2<String, List<Product>>;
          return CupertinoPageRoute<dynamic>(
              builder: (_) => ProductsListView(
                    title: arguments.item1,
                    products: arguments.item2,
                  ));
        }

      case RoutePaths.login:
        return CupertinoPageRoute<dynamic>(builder: (_) => LoginView());

      case RoutePaths.productDetail:
        final product = settings.arguments as Product;
        return CupertinoPageRoute<dynamic>(
            builder: (_) => ProductDetailView(product));

      default:
        return CupertinoPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
