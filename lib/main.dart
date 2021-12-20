import 'package:flutter/material.dart';
import 'package:gm_weather_app/views/web_view.dart';
import 'viewModels/forecast_viewmodel.dart';
import 'views/home_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ForecastViewModel>(
        create: (_) => ForecastViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather GM App',
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
      routes: {WebView.routeName: (context) => const WebView()},
    );
  }
}
