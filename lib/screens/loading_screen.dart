import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getlocationdata();
  }

  void getlocationdata() async {
    var weather = await WeatherModel().getcurrentlocationweather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            currentweatherdata: weather,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitCircle(
            color: Colors.white,
            size: 100.0,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(18.0),
            child: Center(
              child: Text(
                'Please Make sure your phone location is on to get weather Data',
                style: TextStyle(
                  fontFamily: 'Spartan MB',
                  fontSize: 22.0,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
          )
        ],
      ),
    );
  }
}
