import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/screens/location_screen.dart';
import 'package:weather/services/networking.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _locationMessage = '';

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<dynamic> getCityweather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        url:
            'https://api.openweathermap.org/data/2.5/weather?$cityName&appid=a631b8aa337c5b29a6c522fd9c1d5cac&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<void> _getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      setState(() {
        _locationMessage = 'Location permission denied';
      });
      return;
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            'Location permission permanently denied, open settings to grant permission';
      });
      return;
    }

    setState(() {
      _locationMessage = 'Fetching location...';
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() async {
        double latitude = position.latitude;
        double longitude = position.longitude;
        _locationMessage = 'Latitude: $latitude, Longitude: $longitude';
        //getData(latitude, longitude);
        NetworkHelper networkHelper = NetworkHelper(
            url:
                'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=a631b8aa337c5b29a6c522fd9c1d5cac&units=metric');
        var weatherData = await networkHelper.getData();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        }));
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App :)'),
        centerTitle: true,
      ),
      body: const Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}



