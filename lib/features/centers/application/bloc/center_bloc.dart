import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/features/centers/application/usecases/add_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/delete_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/edit_center_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/get_all_centers_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/get_center_details_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/make_phone_call_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/pick_image_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/pick_location_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/search_centers_usecase.dart';
import 'package:hello_pratice/features/centers/application/usecases/search_location_usecase.dart';
import 'package:hello_pratice/features/centers/domain/entities/center.dart';
import 'package:meta/meta.dart';
import 'package:latlong2/latlong.dart';

part 'center_event.dart';
part 'center_state.dart';

class CenterBloc extends Bloc<CenterEvent, CenterState> {
  PickLocationUseCase pickLocationUseCase;
  GetAllCentersUsecase centersUsecase;
  AddCenterUseCase addCenterUseCase;
  EditCenterUsecase editCenterUsecase;
  DeleteCenterUsecase deleteCenterUsecase;
  GetCenterDetailsUsecase getCenterDetailsUsecase;
  SearchCentersUsecase searchCentersUsecase;
  MakePhoneCallUseCase makePhoneCallUseCase;
  PickImageUseCase pickImageUseCase;
  SearchLocationUsecase searchLocationUsecase;

  CenterBloc({
    required this.searchLocationUsecase,
    required this.pickLocationUseCase,
    required this.pickImageUseCase,
    required this.makePhoneCallUseCase,
    required this.searchCentersUsecase,
    required this.getCenterDetailsUsecase,
    required this.deleteCenterUsecase,
    required this.centersUsecase,
    required this.addCenterUseCase,
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

    //GET SEARCH SUGGESSION

    on<LocationSearchQueryChanged>((event, emit) async {
     
      try {
        final suggestions = await searchLocationUsecase.call(event.query);
        emit(LocationSearchLoaded(suggestions));
      } catch (e) {
        emit(LocationSearchError(e.toString()));
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

    //PICK LOCATION

    on<SearchLocationEvent>((event, emit) async {
      try {
        final pickedLocation = await pickLocationUseCase.call(event.query);
        emit(MapUpdated(pickedLocation));
      } catch (e) {
        emit(MapError(e.toString()));
      }
    });

    //MAKE PHONE CALL

    on<MakePhoneCallEvent>((event, emit) async {
      try {
        await makePhoneCallUseCase.call(event.phoneNumber);

        emit(PhoneCallSuccess());
      } catch (e) {
        emit(PhoneCallFailure(e.toString()));
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

    //ADD CENTERS
    on<AddCenterRequested>((event, emit) async {
      try {
        emit(AddCenterLoading());

        await addCenterUseCase.call(event.center);

        emit(AddCenterSuccess("Center added successfully!"));
      } catch (e) {
        emit(CentersError(e.toString()));
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
  }
}
