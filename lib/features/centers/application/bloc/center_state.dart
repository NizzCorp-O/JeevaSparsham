part of 'center_bloc.dart';

@immutable
sealed class CenterState {}

final class CenterInitial extends CenterState {}

//GET ALL CENTERS

class CentersLoading extends CenterState {}

class CentersLoaded extends CenterState {
  final List<PalliativeCenter> centers;
  CentersLoaded(this.centers);
}

class CentersError extends CenterState {
  final String message;
  CentersError(this.message);
}
//GET CENTER DETAIL

class CenterDetailLoading extends CenterState {}

class CenterDetailLoaded extends CenterState {
  final PalliativeCenter center;

  CenterDetailLoaded(this.center);
}

class CenterDetailsError extends CenterState {
  final String message;
  CenterDetailsError(this.message);
}

//SEARCH CENTERS

class SearchCentersLoading extends CenterState {}

class SearchCentersLoaded extends CenterState {
  final List<PalliativeCenter> centers;
  SearchCentersLoaded(this.centers);
}

class SearchCentersError extends CenterState {
  final String message;
  SearchCentersError(this.message);
}

//SEARCH SUGESSION

class LocationSearchLoaded extends CenterState {
  final List<String> suggestions;

  LocationSearchLoaded(this.suggestions);
}

class LocationSearchError extends CenterState {
  final String message;

  LocationSearchError(this.message);
}

//SEARCH LOCATION

class MapUpdated extends CenterState {
  final LatLng? location;
  MapUpdated(this.location);
}

//CALL CENTER

class PhoneCallSuccess extends CenterState {}

class PhoneCallFailure extends CenterState {
  final String message;
  PhoneCallFailure(this.message);
}

//ADD CENTERS

class MapError extends CenterState {
  final String message;

  MapError(this.message);
}

//EDIT CENTERS

class EditCenterLoading extends CenterState {}

class EditCenterSuccess extends CenterState {
  final String message;

  EditCenterSuccess(this.message);
}

//DELETE CENTER

class DeleteCenterLoading extends CenterState {}

class DeleteCenterSuccess extends CenterState {
  final String message;
  DeleteCenterSuccess(this.message);
}

// CREATE CENTER

class CreateCenterLoading extends CenterState {}

class CreateCenterSuccess extends CenterState {
  final String message;
  CreateCenterSuccess(this.message);
}

class CreateCenterError extends CenterState {
  final String message;

  CreateCenterError(this.message);
}

//GET THE ADDRESS ON THE LOCATION

class AddressLoaded extends CenterState {
  final String address;
  AddressLoaded(this.address);
}

class AddressError extends CenterState {
  final String message;
  AddressError(this.message);
}

//PICK IMAGE

class ImagePicked extends CenterState {
  final String imagePath;
  ImagePicked(this.imagePath);
}

class ImagePickFailure extends CenterState {
  final String message;
  ImagePickFailure(this.message);
}

//MOVE MARKER

class MarkerMoved extends CenterState {
  final LatLng markerPosition;

  MarkerMoved(this.markerPosition);
}

class MarkerMoveError extends CenterState {
  final String message;
  MarkerMoveError(this.message);
}

class MarkerBackState extends CenterState {
  final LatLng markerPosition;
  MarkerBackState(this.markerPosition);
}

//SEARCH LOCATION IN MAP

class LocationLoaded extends CenterState {
  final LatLng location;

  LocationLoaded(this.location);
}

class LocationError extends CenterState {
  final String message;

  LocationError(this.message);
}

//SEARCH PLACE BY KEYWORD

class PlaceSuggestionsLoaded extends CenterState {
  final List<String> suggestions;
  PlaceSuggestionsLoaded(this.suggestions);
}

class PlaceSuggestionsError extends CenterState {
  final String message;
  PlaceSuggestionsError(this.message);
}
