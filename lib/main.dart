import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'package:flutter_weather/widgets/Weather.dart';
import 'package:flutter_weather/widgets/WeatherItem.dart';
import 'package:flutter_weather/widgets/CitySelection.dart';
import 'package:flutter_weather/models/WeatherData.dart';
import 'package:flutter_weather/models/ForecastData.dart';

void main() => runApp(
    MaterialApp(
        home: new MyApp()));

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  bool isLoading = false;
  WeatherData weatherData;
  ForecastData forecastData;
  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Weather App',
        theme: ThemeData(
          primaryColor: Colors.teal[900],
        ),

        home: Scaffold(
          backgroundColor: Colors.teal[50],

         // backgroundColor: Image.asset('background.jpg').color,
          appBar: AppBar(
            title: Text('Flutter Weather App'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final city = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CitySelection(),
                    ),
                  );
                  if (city != null){
                    setState(() {
                      isLoading = true;
                    });

                  final cityName = city;
                  final weatherResponse = await http.get(
                      'https://api.openweathermap.org/data/2.5/weather?APPID=9d85f4c068fa545cb544eb01d554f9c3&q=$cityName&units=metric');
                  final forecastResponse = await http.get(
                      'https://api.openweathermap.org/data/2.5/forecast?APPID=9d85f4c068fa545cb544eb01d554f9c3&q=$cityName&units=metric');

                  if (weatherResponse.statusCode == 200 &&
                      forecastResponse.statusCode == 200) {
                    return setState(() {
                      weatherData =
                      new WeatherData.fromJson(jsonDecode(weatherResponse.body));
                      forecastData =
                      new ForecastData.fromJson(jsonDecode(forecastResponse.body));
                      isLoading = false;
                    });
                  }
                }

                setState(() {
                  isLoading = false;
                });
                },
              ),
            ],
          ),

            body: Center(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: weatherData != null ? Weather(
                                weather: weatherData) : Container(),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: isLoading ? CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: new AlwaysStoppedAnimation(
                                  Colors.teal[900]),
                            ) : IconButton(
                              icon: new Icon(Icons.refresh),
                              tooltip: 'Refresh',
                              onPressed: loadWeather,
                              color: Colors.teal[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 300.0,
                          child: forecastData != null ? ListView.builder(
                              itemCount: forecastData.list.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) =>
                                  WeatherItem(
                                      weather: forecastData.list.elementAt(
                                          index))
                          ) : Container(),
                        ),
                      ),
                    )
                  ]
              )
          )
      )
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    Map<String, double> location;

    try {
      location = await _location.getLocation();
      print(location);

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user ro enable it from the app settings';
      }

      location = null;
    }

    if (location != null) {
      final lat = location['latitude'];
      final lon = location['longitude'];

      final weatherResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/weather?APPID=9d85f4c068fa545cb544eb01d554f9c3&lat=${lat
              .toString()}&lon=${lon.toString()}&units=metric');
      final forecastResponse = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?APPID=9d85f4c068fa545cb544eb01d554f9c3&lat=${lat
              .toString()}&lon=${lon.toString()}&units=metric');

      if (weatherResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        return setState(() {
          weatherData =
          new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          forecastData =
          new ForecastData.fromJson(jsonDecode(forecastResponse.body));
          isLoading = false;
        });
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
