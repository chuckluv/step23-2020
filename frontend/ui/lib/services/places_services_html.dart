import 'dart:async';
import 'dart:html';
import 'package:google_maps/google_maps_places.dart';

class PlacesApiServices {
  final AutocompleteService autocompleteService = AutocompleteService();
  final PlacesService placesService =
      PlacesService(document.getElementById("maps"));

  Future<List<AutocompletePrediction>> getAutocomplete(
      String input, List<String> allowedTypes) {
    if (input == null || input == "") {
      return Future.sync(() => []);
    }

    Completer<List<AutocompletePrediction>> completer = Completer();
    AutocompletionRequest request = AutocompletionRequest()..input = input;

    if (allowedTypes.length > 0) {
      request = request..types = allowedTypes;
    }

    autocompleteService.getPlacePredictions(request, (result, status) {
      if (status == PlacesServiceStatus.OK) {
        completer.complete(result);
      } else if (status == PlacesServiceStatus.ZERO_RESULTS) {
        completer.complete([]);
      } else {
        completer.completeError(status);
      }
    });

    return completer.future;
  }

  Future<List<String>> getPhotos(String placeId) {
    Completer<List<String>> completer = Completer();
    final request = PlaceDetailsRequest()..placeId = placeId;
    placesService.getDetails(request, (result, status) async {
      if (status == PlacesServiceStatus.OK) {
        final photoOptions = PhotoOptions()
          ..maxHeight = 500
          ..maxWidth = 500;

        List<String> images =
            result.photos.map((photo) => photo.getUrl(photoOptions));
        completer.complete(images);
      } else {
        completer.complete([]);
      }
    });
    return completer.future;
  }
}
