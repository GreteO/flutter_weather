import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_weather/models/WeatherData.dart';

class WeatherItem extends StatelessWidget {
  final WeatherData weather;

  WeatherItem({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepOrange[100].withOpacity(0.2),
      shape:
      new RoundedRectangleBorder(
        side: new BorderSide(color: Colors.deepOrange[100]),
        borderRadius: BorderRadius.circular(15.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(weather.name, style: new TextStyle(color: Colors.deepOrange[50])),
                new Text(new DateFormat('dd MMM yyyy').format(weather.date), style: new TextStyle(color: Colors.deepOrange[50], fontWeight: FontWeight.bold)),
                new Text(new DateFormat.Hm().format(weather.date), style: new TextStyle(color: Colors.deepOrange[50])),
              ],
            ),
             new Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 new Image.network('https://openweathermap.org/img/w/${weather.icon}.png'),
               ],
             ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Text(weather.main, style: new TextStyle(color: Colors.deepOrange[50], fontSize: 24.0)),
                new Text('${weather.temp.toString()}°C',  style: new TextStyle(color: Colors.deepOrange[50], fontWeight: FontWeight.bold)),
              ],
            ),


          ],

        ),

      ),
    );
  }
}