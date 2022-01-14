import 'package:deva_portal/tools/locator.dart';
import 'package:deva_portal/tools/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'data/uow_providers.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: UowProviders.getProviders(context),
      child: MaterialApp(
        title: 'Deva',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('tr', 'TR'),
          Locale('en', 'US'),
        ],
        locale: Locale('tr'),
        theme: ThemeData(
          primaryColor: Colors.lightBlue.shade800,
          accentColor: Colors.grey.shade600,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: LoginPage(),
        onGenerateRoute: RouteGenerator.routeGenerator,
      ),
    );
  }
}

