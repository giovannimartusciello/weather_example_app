import 'package:flutter/material.dart';
import 'package:gm_weather_app/models/weather.dart';
import 'package:provider/provider.dart';

import 'package:gm_weather_app/viewModels/forecast_viewmodel.dart';
import 'package:gm_weather_app/views/weather_description_view.dart';
import 'package:gm_weather_app/views/weather_summary.dart';

import 'daily_summary_view.dart';
import 'last_update_view.dart';
import 'location_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    onStart();
  }

  Future<void> onStart() async {
    // any init in here ?
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ForecastViewModel>(
      builder: (context, model, child) => Scaffold(
        body: _buildColoredContainer(
            model.condition, model.isDaytime, buildHomeView(context)),
      ),
    );
  }

  Widget buildHomeView(BuildContext context) {
    return Consumer<ForecastViewModel>(
        builder: (context, weatherViewModel, child) => SizedBox(
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
                color: Colors.transparent,
                onRefresh: () => refreshWeather(weatherViewModel, context),
                child: Center(
                    child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20.0),
                  children: <Widget>[
                    weatherViewModel.isRequestPending
                        ? buildBusyIndicator()
                        : weatherViewModel.isRequestError
                            ? Column(children: [
                                const Center(
                                    child: Text('Ooops...something went wrong',
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: Colors.white))),
                                TextButton(
                                  onPressed: () =>
                                      refreshWeather(weatherViewModel, context),
                                  child: const Text("Retry",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                ),
                              ])
                            : Column(children: [
                                LocationView(
                                  city: weatherViewModel.city,
                                ),
                                const SizedBox(height: 50),
                                WeatherSummary(
                                    condition: weatherViewModel.condition,
                                    temp: weatherViewModel.temp,
                                    minTemp: weatherViewModel.minTemp,
                                    maxTemp: weatherViewModel.maxTemp,
                                    humidity: weatherViewModel.humidity,
                                    isdayTime: weatherViewModel.isDaytime),
                                const SizedBox(height: 20),
                                WeatherDescriptionView(
                                    weatherDescription:
                                        weatherViewModel.description),
                                const SizedBox(height: 140),
                                buildDailySummary(weatherViewModel.daily),
                                LastUpdatedView(
                                    lastUpdatedOn:
                                        weatherViewModel.lastUpdated),
                                TextButton(
                                  onPressed: () => {
                                    Navigator.of(context).pushNamed("/webView")
                                  },
                                  child: const Text("Go to web",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.white)),
                                ),
                              ]),
                  ],
                )))));
  }

  Widget buildBusyIndicator() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
      CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ))
    ]);
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dailyForecast
                .map((item) => DailySummaryView(
                      weather: item,
                      key: null,
                    ))
                .toList()));
  }

  Future<void> refreshWeather(
      ForecastViewModel weatherVM, BuildContext context) {
    return weatherVM.getLatestWeather();
  }

  Container _buildColoredContainer(
      WeatherCondition condition, bool isDayTime, Widget child) {
    Container container;

    // if night time then just default to a blue/grey
    if (!isDayTime) {
      container = Container(color: Colors.blueGrey, child: child);
    } else {
      switch (condition) {
        case WeatherCondition.clear:
          container = Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/clear.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: child);
          break;
        case WeatherCondition.lightCloud:
          container = Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/lightcloud.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: child);
          break;
        case WeatherCondition.rain:
          container = Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/rain.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: child);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/heavycloud.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: child);
          break;
        case WeatherCondition.snow:
          container = Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/snow.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: child);
          break;
        case WeatherCondition.thunderstorm:
          container = Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/storm.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: child);
          break;
        default:
          container = Container(color: Colors.grey, child: child);
      }
    }

    return container;
  }
}
