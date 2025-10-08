import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';
import 'package:hello_pratice/features/centers/domain/entities/palliative_center.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_location_field.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_name_field.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/center_phone_field.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/create_center_button.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/pick_location_button.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';

class CreateCenterForm extends StatefulWidget {
  const CreateCenterForm({super.key});
  @override
  State<CreateCenterForm> createState() => _CreateCenterFormState();
}

class _CreateCenterFormState extends State<CreateCenterForm> {
  final TextEditingController centerNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final MapController mapController = MapController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Timer? _debounce;
  String? image;

  @override
  void dispose() {
    super.dispose();
    centerNameController.dispose();
    locationController.dispose();
    phoneNumberController.dispose();
    mapController.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (image != null) {
          context.read<CenterBloc>().add(ClearImageEvent());
          context.read<CenterBloc>().add(ClearImageEvent());
        }
        context.read<CenterBloc>().add(
          MarkerMovedEvent(LatLng(11.2588, 75.7804)),
        );
        return true;
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CenterNameField(centerNameController: centerNameController),
            SizedBox(height: 5),
            CenterLocationField(
              locationController: locationController,
              debounce: _debounce,
            ),
            BlocConsumer<CenterBloc, CenterState>(
              listenWhen: (previous, current) =>
                  current is AddressLoaded || current is ImagePicked,
              buildWhen: (previous, current) =>
                  current is PlaceSuggestionsLoaded ||
                  current is ImagePickFailure,
              listener: (context, state) {
                if (state is AddressLoaded) {
                  locationController.text = state.address;
                } else if (state is ImagePicked) {
                  image = state.imagePath;
                }
              },
              builder: (BuildContext context, CenterState state) {
                if (state is PlaceSuggestionsLoaded) {
                  if (state.suggestions.isEmpty) {
                    return SizedBox();
                  } else {
                    return SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemCount: state.suggestions.length,
                        itemBuilder: (context, index) {
                          final suggestion = state.suggestions[index];
                          return ListTile(
                            title: Text(suggestion),
                            onTap: () {
                              locationController.text = suggestion;
                              context.read<CenterBloc>().add(
                                ClearPlaceSuggestionsEvent(),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }
                }

                return SizedBox();
              },
            ),
            SizedBox(height: 10),
            PickLocationButton(mapController: mapController),
            SizedBox(height: 50),
            CenterPhoneField(phoneNumberController: phoneNumberController),
            SizedBox(height: 20),

            BlocBuilder<CenterBloc, CenterState>(
              buildWhen: (previous, current) => current is CreateCenterLoading,

              builder: (context, state) {
                if (state is CreateCenterLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return CreateCenterButton(
                  onTap: () {
                    if (image != null) {
                      if (_formKey.currentState!.validate()) {
                        final palliativeCenter = PalliativeCenter(
                          image: image!,
                          centerId: '',
                          name: centerNameController.text.trim(),
                          location: locationController.text.trim(),
                          phone: phoneNumberController.text.trim(),
                        );
                        context.read<CenterBloc>().add(
                          CreateCenterRequested(palliativeCenter),
                        );
                        centerNameController.clear();
                        locationController.clear();
                        phoneNumberController.clear();
                        image = null;
                      }
                    } else {
                      AppSnackbar.show(
                        context,
                        message: 'Please select an image',
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
