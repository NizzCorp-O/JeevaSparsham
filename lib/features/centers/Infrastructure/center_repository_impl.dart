import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:hello_pratice/features/centers/domain/repositories/i_center_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:latlong2/latlong.dart';

import 'package:http/http.dart' as http;

class CenterRepositoryImpl extends ICenterRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<List<Center>> getAllPalliativeCenters() async {
    try {
      final centersData = await firestore.collection('centers').get();
      final List<Map<String, dynamic>> centersList = centersData.docs.map((
        center,
      ) {
        return center.data();
      }).toList();

      final List<Center> centers = centersList.map((center) {
        return Center(
          centerId: center['id'],
          adminName: center['adminName'],
          adminPhone: center['adminPhone'],
          adminEmail: center['adminEmail'],
          adminPassword: center['adminPassword'],
          name: center['name'],
          location: center['location'],
          phone: center['phone'],
        );
      }).toList();

      return centers;
    } catch (e) {
      throw 'Failed to get centers.';
    }
  }

  @override
  Future<void> addCenter(Center center) async {
    try {
      final docRef = firestore.collection('centers').doc();
      await docRef.set({
        'id': docRef.id,
        'name': center.name,
        'location': center.location,
        'phone': center.phone,
        'adminName': center.adminName,
        'adminPhone': center.adminPhone,
        'adminEmail': center.adminEmail,
        'adminPassword': center.adminPassword,
      });
    } catch (e) {
      throw "Failed to add center.";
    }
  }

  @override
  Future<void> editCenter({
    required String centerId,
    required Center center,
  }) async {
    try {
      firestore.collection('centers').doc(centerId).update({
        if (center.name.isNotEmpty) 'name': center.name,
        if (center.location.isNotEmpty) 'location': center.location,
        if (center.phone.isNotEmpty) 'phone': center.phone,
        if (center.adminName.isNotEmpty) 'adminName': center.adminName,
        if (center.adminPhone.isNotEmpty) 'adminPhone': center.adminPhone,
        if (center.adminEmail.isNotEmpty) 'adminEmail': center.adminEmail,
        if (center.adminPassword.isNotEmpty)
          'adminPassword': center.adminPassword,
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

  @override
  Future<Center> getCenterDetails(String centerId) async {
    try {
      final centerData = await firestore
          .collection('centers')
          .doc(centerId)
          .get();

      final centerDetails = centerData.data();
      final center = Center(
        adminName: centerDetails?['adminName'],
        adminPhone: centerDetails?['adminPhone'],
        adminEmail: centerDetails?['adminEmail'],
        adminPassword: centerDetails?['adminPassword'],
        name: centerDetails?['name'],
        location: centerDetails?['location'],
        phone: centerDetails?['phone'],
        centerId: centerDetails?['id'],
      );
      return center;
    } catch (e) {
      throw 'Failed to get center';
    }
  }

  @override
  Future<List<Center>> searchCenters(String query) async {
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

  @override
  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await launchUrl(uri);
  }

  @override
  Future<String?> pickImageFromGallery() async {
    try {
      final ImagePicker picker = ImagePicker();

      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      return image?.path;
    } catch (e) {
      throw 'Failed to pick image';
    }
  }

  @override
  Future<LatLng?> searchLocation(String query) async {
    if (query.isEmpty) return null;

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1',
    );
    final response = await http.get(
      url,
      headers: {"User-Agent": "flutter_app"},
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

    return null;
  }

  @override
  Future<List<String>> fetchPlaceSuggestions(String query) async {
    try {
      if (query.isEmpty) return [];

      final url = Uri.parse(
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5",
      );

      final response = await http.get(
        url,
        headers: {"User-Agent": "your_app_name/1.0"},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((e) => e['display_name'] as String).toList();
      } else {
        throw Exception(
          "Failed to fetch suggestions (code: ${response.statusCode})",
        );
      }
    } catch (e) {
      throw Exception("Error fetching place suggestions: $e");
    }
  }
}
