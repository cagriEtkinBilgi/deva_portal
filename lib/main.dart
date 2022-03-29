import 'package:deva_portal/tools/deva_thema.dart';
import 'package:deva_portal/tools/locator.dart';
import 'package:deva_portal/tools/route_generator.dart';
import 'package:flutter/material.dart';
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
        theme: DevaThema,
        //home: LoginPage(),
        onGenerateRoute: RouteGenerator.routeGenerator,
      ),
    );
  }
}

