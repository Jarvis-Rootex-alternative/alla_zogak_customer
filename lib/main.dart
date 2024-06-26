import 'package:alla_zogak_customer/providers/wishlist_provider.dart';
import 'package:alla_zogak_customer/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../models/products.dart';
import '../providers/address_provider.dart';
import '../providers/cart_provider.dart';
import '../screens/login_screen.dart';
import 'providers/user_provider.dart';
import 'screens/Landing/intro_slider.dart';
import 'screens/Landing/splash.dart';
import 'screens/home_page.dart';
import 'screens/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartBloc()),
      ChangeNotifierProvider(create: (_) => WishlistBloc()),
      ChangeNotifierProvider(create: (_) => AddressBloc()),
      ChangeNotifierProvider(create: (_) => UserBloc())
    ],
    child: MyApp(savedThemeMode: savedThemeMode),
  ));
}

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;
  const MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Super Digital Market',
      // ignore: unrelated_type_equality_checks
      theme: Constants.lightmode,
      darkTheme: AdaptiveTheme.of(context).darkTheme,
      initialRoute: "/",
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "intro":
            return MaterialPageRoute(builder: (_) => const IntroSliderScreen());
          case "login":
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          case "home":
            return MaterialPageRoute(builder: (_) => const HomePage());
          case "product":
            return MaterialPageRoute(
                builder: (_) => ProductSc(
                      product: settings.arguments as Products,
                    ));
          default:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
        }
      },
      locale: const Locale("ar", "SA"),
      supportedLocales: const [Locale("ar", "SA")],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
