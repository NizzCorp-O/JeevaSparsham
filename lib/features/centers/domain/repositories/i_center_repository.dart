import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:latlong2/latlong.dart';

abstract class ICenterRepository {
  Future<List<Center>> getAllPalliativeCenters();
  Future<Center> getCenterDetails(String centerId);

  Future<void> addCenter(Center center);
  Future<void> editCenter({required String centerId, required Center center});
  Future<void> deleteCenter(String centerId);

  Future<List<Center>> searchCenters(String query);
  Future<void> makePhoneCall(String phoneNumber);

  Future<String?> pickImageFromGallery();

  Future<LatLng?> searchLocation(String query);
  Future<List<String>> fetchPlaceSuggestions(String query);
}
