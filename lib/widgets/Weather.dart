import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_weather/models/WeatherData.dart';


class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

      children: <Widget>[
        Text(weather.name, style: new TextStyle(color: Colors.teal[900])),
        Text(weather.main, style: new TextStyle(color: Colors.teal[900], fontSize: 32.0)),
        Text('${weather.temp.toString()}°C',  style: new TextStyle(color: Colors.teal[900], fontWeight: FontWeight.bold)),
        Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
        Text(new DateFormat('dd MMM yyyy').format(weather.date), style: new TextStyle(color: Colors.teal[900])),
        Text(new DateFormat.Hm().format(weather.date), style: new TextStyle(color: Colors.teal[900])),
      ],
    );
  }
}