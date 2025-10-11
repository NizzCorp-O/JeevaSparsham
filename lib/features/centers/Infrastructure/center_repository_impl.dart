import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;

class CenterRepositoryImpl extends ICenterRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //GET ALL CENTERS
  @override
  Future<List<PalliativeCenter>> getAllPalliativeCenters() async {
    try {
      final centersData = await firestore.collection('centers').get();
      final List<Map<String, dynamic>> centersList = centersData.docs.map((
        center,
      ) {
        return center.data();
      }).toList();

      final List<PalliativeCenter> centers = centersList.map((center) {
        return PalliativeCenter(
          centerId: center['id'],
          name: center['name'],
          location: center['location'],
          phone: center['phone'],
          image: center['imageUrl'],
        );
      }).toList();

      return centers;
    } catch (e) {
      throw 'Failed to get centers.';
    }
  }

  @override
  Future<void> editCenter({
    required String centerId,
    required PalliativeCenter center,
  }) async {
    try {
      firestore.collection('centers').doc(centerId).update({
        if (center.name.isNotEmpty) 'name': center.name,
        if (center.location.isNotEmpty) 'location': center.location,
        if (center.phone.isNotEmpty) 'phone': center.phone,
      });
    } catch (e) {
      throw "Failed to edit center";
    }
  }

  @override
  Future<void> deleteCenter(String centerId) async {
    try {
      await firestore.collection('centers').doc(centerId).delete();
    } catch (e) {
      throw "Failed to delete center";
    }
  }

  //GET CENTER DETAIL

  @override
  Future<PalliativeCenter> getCenterDetails(String centerId) async {
    try {
      final centerData = await firestore
          .collection('centers')
          .doc(centerId)
          .get();

      final centerDetails = centerData.data();
      final center = PalliativeCenter(
        name: centerDetails?['name'],
        location: centerDetails?['location'],
        phone: centerDetails?['phone'],
        centerId: centerDetails?['id'],
        image: centerDetails?['imageUrl'],
      );
      return center;
    } catch (e) {
      throw 'Failed to get center.';
    }
  }

  //SEARCH CENTERS
  @override
  Future<List<PalliativeCenter>> searchCenters(String query) async {
    try {
      final centers = await getAllPalliativeCenters();
      final filteredCenters = centers.where((center) {
        return center.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      return filteredCenters;
    } catch (e) {
      throw 'Failed to get centers.';
    }
  }

  //CALL CENTER

  @override
  Future<void> makePhoneCall(String phoneNumber) async {
    try {
      final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
      await launchUrl(uri);
    } catch (e) {
      throw "Failed to make phone call..";
    }
  }

  // CREATE CENTER

  @override
  Future<void> createCenter(PalliativeCenter palliativeCenter) async {
    try {
      final docRef = firestore.collection('centers').doc();
      await docRef.set({
        'id': docRef.id,
        'imageUrl': palliativeCenter.image,
        'name': palliativeCenter.name,
        'location': palliativeCenter.location,
        'phone': palliativeCenter.phone,
      });
    } catch (e) {
      throw "Failed to create center.";
    }
  }

  //PICK IMAGE

  @override
  Future<String?> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        throw 'Failed to pick image.';
      }
      return image.path;
    } catch (e) {
      throw 'Failed to pick image.';
    }
  }

  //SEARCH LOCATION IN MAP

  @override
  Future<LatLng?> searchLocation(String query) async {
    try {
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1',
      );
      final response = await http.get(
        url,
        headers: {
          "User-Agent": "hello_pratice/0.1.0 (nihaddevkdp@gmail.com)",
          "Accept-Language": "en",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          return LatLng(
            double.parse(data[0]['lat']),
            double.parse(data[0]['lon']),
          );
        }
      }
    } catch (e) {
      throw "Failed to search location.";
    }
    throw "Failed to search location.";
  }

  //GET THE ADDRESS ON THE LOCATION

  @override
  Future<String?> getAddressFromCoordinates({
    required double lat,
    required double lon,
  }) async {
    try {
      final url = Uri.parse(
        "https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$lon&format=json",
      );

      final response = await http.get(
        url,
        headers: {"User-Agent": "MyFlutterApp/1.0"},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["display_name"];
      } else {
        return "$lat, $lon";
      }
    } catch (e) {
      throw "Failed to get location.";
    }
  }

  //SEARCH PLACE BY KEYWORD

  @override
  Future<List<String>> searchPlacesByQuery(String query) async {
    try {
      final url = Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5",
      );

      final response = await http.get(
        url,
        headers: {"User-Agent": "MyFlutterApp/1.0"},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        return data.map((e) => e['display_name'] as String).toList();
      } else {
        throw "Failed to fetch suggestions.";
      }
    } catch (e) {
      throw "Error fetching place suggestions.";
    }
  }
}
