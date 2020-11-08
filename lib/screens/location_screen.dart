import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'city_screen.dart';

int temperature;
String condition;
String message;
String cityname;

class LocationScreen extends StatefulWidget {
  final currentweatherdata;
  LocationScreen({this.currentweatherdata});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    getdata(widget.currentweatherdata);
  }

  WeatherModel weatherModel = WeatherModel();
  void getdata(dynamic weather) {
    setState(() {
      if (weather == null) {
        temperature = 0;
        condition = 'Error';
        message = 'We are failed to fetch weather data';
        cityname = '';
        return;
      }
      double temp = jsonDecode(weather)['main']['temp'];
      temperature = (temp - 273.15).toInt();
      var weatherid = jsonDecode(weather)['weather'][0]['id'];
      cityname = jsonDecode(weather)['name'];

      condition = weatherModel.getWeatherIcon(weatherid);
      message = weatherModel.getMessage(temperature);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weather =
                          await WeatherModel().getcurrentlocationweather();
                      getdata(weather);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var city = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (city != null) {
                        var weather = await WeatherModel().getcityweather(city);
                        getdata(weather);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$condition️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityname!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
