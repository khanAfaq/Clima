// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _locationMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _getLocation();
//   }

//   Future<void> _getLocation() async {
//     LocationPermission permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       setState(() {
//         _locationMessage = 'Location permission denied';
//       });
//       return;
//     }

//     if (permission == LocationPermission.deniedForever) {
//       setState(() {
//         _locationMessage =
//             'Location permission permanently denied, open settings to grant permission';
//       });
//       return;
//     }

//     setState(() {
//       _locationMessage = 'Fetching location...';
//     });

//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       setState(() {
//         double latitude = position.latitude;
//         double longitude = position.longitude;
//         _locationMessage = 'Latitude: $latitude, Longitude: $longitude';
//       });
//     } catch (e) {
//       setState(() {
//         _locationMessage = 'Error: ${e.toString()}';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Geolocator Example'),
//       ),
//       body: Center(
//         child: Text(
//           _locationMessage,
//           style: const TextStyle(fontSize: 20.0),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     );
//   }
// }
