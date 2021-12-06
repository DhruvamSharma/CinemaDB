import 'package:cinema_db/core/custom_theme.dart';
import 'package:cinema_db/core/route_generator.dart';
import 'package:cinema_db/features/cinema/presentation/pages/cinema_listing_route.dart';
import 'package:cinema_db/injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  await di.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CustomTheme.darkTheme,
      initialRoute: CinemaListingRoute.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
