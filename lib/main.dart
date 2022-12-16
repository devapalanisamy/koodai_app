import 'package:ConsumerApp/src/core/configs/app_config.dart';
import 'package:ConsumerApp/src/core/configs/enum.dart';
import 'package:ConsumerApp/src/core/services/authentication/i_authentication_service.dart';
import 'package:ConsumerApp/src/core/services/navigation/i_navigation_service.dart';
import 'package:ConsumerApp/src/service_locator.dart';
import 'package:ConsumerApp/src/ui/route_paths.dart';
import 'package:ConsumerApp/src/ui/router.dart';
import 'package:ConsumerApp/src/ui/theme/custom_color_scheme.dart';
import 'package:ConsumerApp/src/ui/views/login_view.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  setupServiceLocator(AppConfig(
    baseUrl: 'demo-koodai-api.cbedigital.co.uk',
  ));
  final isLoggedIn =
      await serviceLocator<IAuthenticationService>().isLoggedIn();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({Key key, this.isLoggedIn}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            textTheme:
                GoogleFonts.workSansTextTheme(Theme.of(context).textTheme),
            primarySwatch: Colors.lightGreen,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: CustomColorScheme.getColorScheme(),
            buttonColor: CustomColorScheme.getColorScheme().secondary,
            buttonTheme: ButtonThemeData(
              buttonColor: CustomColorScheme.getColorScheme().secondary,
              colorScheme: CustomColorScheme.getColorScheme(),
              textTheme: ButtonTextTheme.primary,
            ),
            dividerTheme: DividerThemeData(
                color: CustomColorScheme.getColorScheme().secondary)),
        home: LoginView(),
        onGenerateRoute: Router.generateRoute,
        initialRoute: isLoggedIn ? RoutePaths.bottomTabBar : RoutePaths.login,
        navigatorKey: serviceLocator<INavigationService>()
            .navigatorKeys[NavigationFlow.Default]);
  }
}
