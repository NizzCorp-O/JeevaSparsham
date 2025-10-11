import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/centers/application/usecases/create_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/delete_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/edit_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/get_address_from_coordinates_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/get_all_centers_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/get_center_details_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/make_phone_call_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/pick_image_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/pick_location_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/search_centers_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/search_location_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/search_place_suggestions_usecase.dart';
import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:meta/meta.dart';
import 'package:latlong2/latlong.dart';

part 'center_event.dart';
part 'center_state.dart';

class CenterBloc extends Bloc<CenterEvent, CenterState> {
  PickLocationUseCase pickLocationUseCase;
  GetAllCentersUsecase centersUsecase;
  CreateCenterUsecase createCenterUsecase;
  EditCenterUsecase editCenterUsecase;
  DeleteCenterUsecase deleteCenterUsecase;
  GetCenterDetailsUsecase getCenterDetailsUsecase;
  SearchCentersUsecase searchCentersUsecase;
  MakePhoneCallUseCase makePhoneCallUseCase;
  PickImageUseCase pickImageUseCase;
  SearchLocationUsecase searchLocationUsecase;
  GetAddressFromCoordinatesUseCase getAddressFromCoordinatesUseCase;
  SearchPlaceSuggestionsUseCase searchPlaceSuggestionsUseCase;
  CenterBloc({
    required this.searchPlaceSuggestionsUseCase,
    required this.getAddressFromCoordinatesUseCase,
    required this.searchLocationUsecase,
    required this.pickLocationUseCase,
    required this.pickImageUseCase,
    required this.makePhoneCallUseCase,
    required this.searchCentersUsecase,
    required this.getCenterDetailsUsecase,
    required this.deleteCenterUsecase,
    required this.centersUsecase,
    required this.createCenterUsecase,
    required this.editCenterUsecase,
  }) : super(CenterInitial()) {
    //GET ALL CENTERS
    on<GetAllCentersEvent>((event, emit) async {
      try {
        emit(CentersLoading());

        final centersList = await centersUsecase.call();

        emit(CentersLoaded(centersList));
      } catch (e) {
        emit(CentersError(e.toString()));
      }
    });

    //GET CENTER DETAILS

    on<GetCenterDetailsEvent>((event, emit) async {
      try {
        emit(CenterDetailLoading());

        final center = await getCenterDetailsUsecase.call(event.centerId);

        emit(CenterDetailLoaded(center));
      } catch (e) {
        emit(CenterDetailsError(e.toString()));
      }
    });



    //SEARCH CENTERS

    on<SearchCenters>((event, emit) async {
      try {
        emit(SearchCentersLoading());
        final searachedCenters = await searchCentersUsecase.call(event.query);
        emit(SearchCentersLoaded(searachedCenters));
      } catch (e) {
        emit(SearchCentersError(e.toString()));
      }
    });

    //CALL CENTER

    on<MakePhoneCallEvent>((event, emit) async {
      try {
        await makePhoneCallUseCase.call(event.phoneNumber);

        emit(PhoneCallSuccess());
      } catch (e) {
        emit(PhoneCallFailure(e.toString()));
      }
    });

    //EDIT CENTER
    on<EditCenterRequested>((event, emit) async {
      try {
        emit(EditCenterLoading());

        await editCenterUsecase.call(
          center: event.center,
          centerId: event.centerId,
        );

        emit(EditCenterSuccess("Center edited successfully!"));
      } catch (e) {
        emit(CentersError(e.toString()));
      }
    });

    //DELETE CENTER
    on<DeleteCenterRequested>((event, emit) async {
      try {
        emit(DeleteCenterLoading());

        await deleteCenterUsecase.call(event.centerId);

        emit(DeleteCenterSuccess("Center deleted successfully!"));
      } catch (e) {
        emit(CentersError(e.toString()));
      }
    });

    // CREATE CENTER

    on<CreateCenterRequested>((event, emit) async {
      try {
        emit(CreateCenterLoading());

        await createCenterUsecase.call(event.center);

        emit(CreateCenterSuccess("Center added successfully!"));
      } catch (e) {
        emit(CreateCenterError(e.toString()));
      }
    });

    //PICK IMAGE

    on<PickImageFromGallery>((event, emit) async {
      try {
        final imagePath = await pickImageUseCase.call();
        emit(ImagePicked(imagePath!));
      } catch (e) {
        emit(ImagePickFailure(e.toString()));
      }
    });

    on<ClearImageEvent>((event, emit) async {
      emit(ImagePickFailure('Image cleared'));
    });

    //GET THE ADDRESS ON THE LOCATION

    on<GetAddressFromCoordinatesRequested>((event, emit) async {
      try {
        final address = await getAddressFromCoordinatesUseCase.call(
          lat: event.lat,
          lon: event.lon,
        );
        emit(AddressLoaded(address!));
      } catch (e) {
        emit(AddressError(e.toString()));
      }
    });

    //MOVE MARKER

    on<MarkerMovedEvent>((event, emit) async {
      try {
        emit(MarkerMoved(event.newPosition));
      } catch (e) {
        emit(MarkerMoveError("Failed to move marker."));
      }
    });

    on<ClearLocationEvent>((event, emit) async {
      emit(MarkerBackState(LatLng(11.2588, 75.7804)));
    });

    //SEARCH LOCATION IN MAP

    on<SearchLocationEvent>((event, emit) async {
      try {
        final location = await searchLocationUsecase.call(event.query);
        emit(LocationLoaded(location!));
      } catch (e) {
        emit(LocationError(e.toString()));
      }
    });

    //SEARCH PLACE BY KEYWORD

    on<SearchPlaceSuggestionsEvent>((event, emit) async {
      try {
        final suggestions = await searchPlaceSuggestionsUseCase.call(
          event.query,
        );
        emit(PlaceSuggestionsLoaded(suggestions));
      } catch (e) {
        emit(PlaceSuggestionsError(e.toString()));
      }
    });

    on<ClearPlaceSuggestionsEvent>((event, emit) {
      emit(PlaceSuggestionsLoaded([]));
    });
  }
}
