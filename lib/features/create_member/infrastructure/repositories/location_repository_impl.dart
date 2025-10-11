import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hello_pratice/features/create_member/domain/entities/repositories/member_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
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
        headers: {
          "User-Agent": "palliative-care-app/1.0" // ✅ must add
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data["display_name"];
      } else {
        return "$lat, $lon"; // fallback
      }
    } catch (e) {
      return "$lat, $lon"; // fallback if error
    }
  }
}
