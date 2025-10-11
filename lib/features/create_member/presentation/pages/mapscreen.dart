// // --- Map Picker Screen ---
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';

// class MapPickerScreen extends StatefulWidget {
//   final LatLng initialLocation;
//   const MapPickerScreen({super.key, required this.initialLocation});

//   @override
//   State<MapPickerScreen> createState() => _MapPickerScreenState();
// }

// class _MapPickerScreenState extends State<MapPickerScreen> {
//   late LatLng pickedLocation;

//   @override
//   void initState() {
//     super.initState();
//     pickedLocation = widget.initialLocation;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pick Location'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.check),
//             onPressed: () => Navigator.pop(context, pickedLocation),
//           ),
//         ],
//       ),
//       body: FlutterMap(
//         options: MapOptions(
//           center: pickedLocation,
//           zoom: 13.0,
//           onTap: (tapPosition, point) {
//             setState(() {
              
//               pickedLocation = point;
//             });
//           },
//         ),
//         children: [
//           TileLayer(
//             urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//             // subdomains: const ['a', 'b', 'c'],
//           ),
//           MarkerLayer(
//             markers: [
//               Marker(
//                 point: pickedLocation,
//                 width: 40,
//                 height: 40,
//                 child: const Icon(
//                   Icons.location_on,
//                   size: 40,
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
