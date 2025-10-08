import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:latlong2/latlong.dart';

abstract class ICenterRepository {
  Future<List<PalliativeCenter>> getAllPalliativeCenters();
  Future<PalliativeCenter> getCenterDetails(String centerId);

  Future<void> editCenter({
    required String centerId,
    required PalliativeCenter center,
  });
  Future<void> deleteCenter(String centerId);

  Future<List<PalliativeCenter>> searchCenters(String query);
  Future<void> makePhoneCall(String phoneNumber);

  Future<void> createCenter(PalliativeCenter center);


  Future<String?> pickImageFromGallery();

  Future<List<String>> searchPlacesByQuery(String query);

  Future<LatLng?> searchLocation(String query);

  
  Future<String?> getAddressFromCoordinates({
    required double lat,
    required double lon,
  });
}
