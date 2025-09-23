part of 'center_bloc.dart';

@immutable
sealed class CenterState {}

final class CenterInitial extends CenterState {}

//GET ALL CENTERS

class CentersLoading extends CenterState {}

class CentersLoaded extends CenterState {
  final List<Center> centers;
  CentersLoaded(this.centers);
}

//GET CENTER DETAILS

class CenterDetailLoading extends CenterState {}

class CenterDetailLoaded extends CenterState {
  final Center center;

  CenterDetailLoaded(this.center);
}

class CenterDetailsError extends CenterState {
  final String message;
  CenterDetailsError(this.message);
}

//SEARCH CENTERS

class SearchCentersLoading extends CenterState {}

class SearchCentersLoaded extends CenterState {
  final List<Center> centers;
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

//PICK IMAGE

class ImagePicked extends CenterState {
  final String imagePath;
  ImagePicked(this.imagePath);
}

class ImagePickFailure extends CenterState {
  final String message;
  ImagePickFailure(this.message);
}

//MAKE PHONE CALL

class PhoneCallSuccess extends CenterState {}

class PhoneCallFailure extends CenterState {
  final String message;
  PhoneCallFailure(this.message);
}

//ADD CENTERS

class AddCenterLoading extends CenterState {}

class AddCenterSuccess extends CenterState {
  final String message;
  AddCenterSuccess(this.message);
}

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

//ERROR

class CentersError extends CenterState {
  final String message;
  CentersError(this.message);
}
