import 'dart:convert';
import 'package:tripmeout/model/trip.dart';
import 'package:http/http.dart' as http;
import 'package:tripmeout/services/trip_service.dart';

class RestApiTripService implements TripService {
  Future<List<Trip>> listTrips() async {
    final response = await http.get('/api/trips');
    if (response.statusCode == 200) {
      var asList =
          (json.decode(response.body) as List).cast<Map<String, dynamic>>();
      return asList.map((x) => Trip.fromJson(x)).toList();
    } else {
      throw Exception('Failed to get List of trips');
    }
  }

  Future<Trip> getTrip(String id) async {
    final response = await http.get('/api/trips/$id');
    if (response.statusCode == 200) {
      return Trip.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get Trip');
    }
  }

  Future<Trip> createTrip(Trip trip) async {
    final http.Response response = await http.post(
      '/api/trips',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': trip.name,
        'locationLat': trip.location.latitude,
        'locationLong': trip.location.longitude,
      }),
    );
    if (response.statusCode == 200) {
      return Trip.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Trip');
    }
  }
}
