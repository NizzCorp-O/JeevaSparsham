part of 'center_bloc.dart';

@immutable
sealed class CenterEvent {}

//GET ALL CENTERS

class GetAllCentersEvent extends CenterEvent {}

//GET CENTER DETAIL

class GetCenterDetailsEvent extends CenterEvent {
  final String centerId;
  GetCenterDetailsEvent(this.centerId);
}

//SEARCH CENTERS

class SearchCenters extends CenterEvent {
  final String query;
  SearchCenters(this.query);
}

//GET SUGGESTION

class LocationSearchQueryChanged extends CenterEvent {
  final String query;

  LocationSearchQueryChanged(this.query);
}

//CALL CENTER

class MakePhoneCallEvent extends CenterEvent {
  final String phoneNumber;
  MakePhoneCallEvent(this.phoneNumber);
}

//EDIT CENTER

// ignore: must_be_immutable
class EditCenterRequested extends CenterEvent {
  final String centerId;
  PalliativeCenter center;
  EditCenterRequested({required this.center, required this.centerId});
}

//DELETE CENTER

class DeleteCenterRequested extends CenterEvent {
  final String centerId;
  DeleteCenterRequested(this.centerId);
}

// CREATE CENTER

class CreateCenterRequested extends CenterEvent {
  final PalliativeCenter center;

  CreateCenterRequested(this.center);
}

//GET THE ADDRESS ON THE LOCATION

class GetAddressFromCoordinatesRequested extends CenterEvent {
  final double lat;
  final double lon;

  GetAddressFromCoordinatesRequested({required this.lat, required this.lon});
}

//PICK IMAGE

class PickImageFromGallery extends CenterEvent {}

class ClearImageEvent extends CenterEvent {}

//MOVE MARKER

class MarkerMovedEvent extends CenterEvent {
  final LatLng newPosition;
  MarkerMovedEvent(this.newPosition);
}

class ClearLocationEvent extends CenterEvent {}


//SEARCH LOCATION IN MAP

class SearchLocationEvent extends CenterEvent {
  final String query;
  SearchLocationEvent(this.query);
}

//SEARCH PLACE BY KEYWORD

class SearchPlaceSuggestionsEvent extends CenterEvent {
  final String query;
  SearchPlaceSuggestionsEvent(this.query);
}

class ClearPlaceSuggestionsEvent extends CenterEvent {}
