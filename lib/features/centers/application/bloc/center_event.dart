part of 'center_bloc.dart';

@immutable
sealed class CenterEvent {}

//GET ALL CENTERS

class GetAllCentersEvent extends CenterEvent {}

//GET CENTER DETAILS
class GetCenterDetailsEvent extends CenterEvent {
  final String centerId;
  GetCenterDetailsEvent(this.centerId);
}

//SEARCH CENTERS

class SearchCenters extends CenterEvent {
  final String query;
  SearchCenters(this.query);
}

//SEARCH LOCATION
class SearchLocationEvent extends CenterEvent {
  final String query;
  SearchLocationEvent(this.query);
}

//GET SUGGESTION

class LocationSearchQueryChanged extends CenterEvent {
  final String query;

  LocationSearchQueryChanged(this.query);
}

//MAKE PHONE CALL

class MakePhoneCallEvent extends CenterEvent {
  final String phoneNumber;
  MakePhoneCallEvent(this.phoneNumber);
}

//PICK IMAGE

class PickImageFromGallery extends CenterEvent {}

//ADD CENTERS

class AddCenterRequested extends CenterEvent {
  final Center center;

  AddCenterRequested(this.center);
}

//EDIT CENTER

// ignore: must_be_immutable
class EditCenterRequested extends CenterEvent {
  final String centerId;
  Center center;
  EditCenterRequested({required this.center, required this.centerId});
}

//DELETE CENTER

class DeleteCenterRequested extends CenterEvent {
  final String centerId;
  DeleteCenterRequested(this.centerId);
}
