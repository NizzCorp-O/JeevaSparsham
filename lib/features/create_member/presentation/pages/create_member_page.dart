import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hello_pratice/features/members/application/bloc/members_bloc.dart';
import 'package:hello_pratice/features/members/application/bloc/members_event.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:hello_pratice/features/create_member/application/bloc/admin_bloc.dart';
import 'package:hello_pratice/features/create_member/application/usecases/create_member.dart';
import 'package:hello_pratice/features/create_member/application/usecases/mappicking.dart';
import 'package:hello_pratice/features/create_member/domain/entities/members.dart';
import 'package:hello_pratice/features/create_member/infrastructure/repositories/location_repository_impl.dart';
import 'package:hello_pratice/features/create_member/infrastructure/repositories/member_repository_impl.dart';

class CreateMemberScreen extends StatefulWidget {
  const CreateMemberScreen({super.key});

  @override
  State<CreateMemberScreen> createState() => _CreateMemberScreenState();
}

class _CreateMemberScreenState extends State<CreateMemberScreen> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();

  final MapController mapController = MapController();
  final _pickedLocationNotifier = ValueNotifier<LatLng>(
    LatLng(9.9312, 76.2673),
  ); // Default: Kochi

  final formkey = GlobalKey<FormState>();

  final _profileImageNotifier = ValueNotifier<File?>(null);
  final ImagePicker _picker = ImagePicker();
  String? _imageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );
    if (pickedFile != null) {
      _profileImageNotifier.value = File(pickedFile.path);
    }
  }

  final _selectedRoleNotifier = ValueNotifier<String?>(null);
  final List<String> _roles = ['Doctor', 'Nurse', 'Volunteer'];

  final Map<String, List<String>> roleSkills = {
    'Doctor': ['Emergency Care', 'Patient Management'],
    'Nurse': ['Patient Management', 'First Aid'],
    'Volunteer': ['First Aid'],
  };

  final _availableSkillsNotifier = ValueNotifier<List<String>>([]);
  final _selectedSkillsNotifier = ValueNotifier<List<String>>([]);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(
        createMemberUseCase: CreateMember(
          MemberRepositoryImpl(FirebaseFirestore.instance),
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Create Member'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        backgroundColor: const Color(0xFFF9F7F4),
        body: BlocListener<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is CreateMemberSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Member Created Successfully")),
              );
              _nameController.clear();
              _mobileController.clear();
              _emailController.clear();
              _locationController.clear();
              _selectedRoleNotifier.value = null;
              _availableSkillsNotifier.value = [];
              _selectedSkillsNotifier.value = [];
              _profileImageNotifier.value = null;
            } else if (state is AdminFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Failed: ${state.message}")),
              );
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Profile Photo ---
                  Center(
                    child: ValueListenableBuilder<File?>(
                      valueListenable: _profileImageNotifier,
                      builder: (context, profileImage, child) {
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: const Color(0xFFE0E0E0),
                              backgroundImage: profileImage != null
                                  ? FileImage(profileImage)
                                  : null,
                              child: profileImage == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: const CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.green,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: _pickImage,
                      child: const Text(
                        'Upload Photo',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Name ---
                  _buildTextFieldLabel('Name'),
                  TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Full name is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter full name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      errorMaxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Role ---
                  _buildTextFieldLabel('Role'),
                  ValueListenableBuilder<String?>(
                    valueListenable: _selectedRoleNotifier,
                    builder: (context, selectedRole, child) {
                      return Wrap(
                        spacing: 8.0,
                        children: _roles.map((role) {
                          return ChoiceChip(
                            label: Text(role),
                            selected: selectedRole == role,
                            onSelected: (isSelected) {
                              if (isSelected) {
                                _selectedRoleNotifier.value = role;
                                _availableSkillsNotifier.value =
                                    roleSkills[role] ?? [];
                                _selectedSkillsNotifier.value = [];
                              }
                            },
                            selectedColor: Colors.teal[100],
                            backgroundColor: Colors.white,
                            shape: StadiumBorder(
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                  const SizedBox(height: 16),

                  // --- Mobile ---
                  _buildTextFieldLabel('Mobile Number'),
                  TextFormField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Phone Number is required";
                      } else if (value.length < 10) {
                        return "Invalid Phone Number";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: '(91+ 1234567890)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      errorMaxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Email (Optional) ---
                  _buildTextFieldLabel('Email (Optional)'),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return "Enter a valid email address";
                        }
                      }
                      return null; // empty allowed
                    },
                    decoration: InputDecoration(
                      hintText: 'example@gmail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      errorMaxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Location ---
                  _buildTextFieldLabel('Location'),
                  TextField(
                    controller: _locationController,
                    readOnly: true,
                    decoration: InputDecoration(
                      hintText: 'Select location',
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      errorMaxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  OutlinedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Pick Location"),
                          content: SizedBox(
                            width: 300,
                            height: 300,
                            child: FlutterMap(
                              mapController: mapController,
                              options: MapOptions(
                                initialCenter: _pickedLocationNotifier.value,
                                initialZoom: 13.0,
                                onTap: (tapPosition, point) async {
                                  _pickedLocationNotifier.value = point;
                                  final useCase = GetAddressFromCoordinates(
                                    LocationRepositoryImpl(),
                                  );
                                  final address = await useCase.call(
                                    point.latitude,
                                    point.longitude,
                                  );
                                  _locationController.text =
                                      address ??
                                      "${point.latitude}, ${point.longitude}";
                                },
                              ),
                              children: [
                                TileLayer(
                                  urlTemplate:
                                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                                ),
                                ValueListenableBuilder<LatLng>(
                                  valueListenable: _pickedLocationNotifier,
                                  builder: (context, pickedLocation, child) {
                                    return MarkerLayer(
                                      markers: [
                                        Marker(
                                          width: 40,
                                          height: 40,
                                          point: pickedLocation,
                                          child: const Icon(
                                            Icons.location_on,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text("Done"),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Pick from Map'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      foregroundColor: Colors.teal,
                      side: BorderSide(color: Colors.teal[200]!),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // --- Skills ---
                  _buildTextFieldLabel('Skills'),
                  ValueListenableBuilder<List<String>>(
                    valueListenable: _availableSkillsNotifier,
                    builder: (context, availableSkills, child) {
                      return ValueListenableBuilder<List<String>>(
                        valueListenable: _selectedSkillsNotifier,
                        builder: (context, selectedSkills, child) {
                          return Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: availableSkills.map((skill) {
                              return FilterChip(
                                label: Text(skill),
                                selected: selectedSkills.contains(skill),
                                onSelected: (isSelected) {
                                  final currentSkills = List<String>.from(
                                    _selectedSkillsNotifier.value,
                                  );
                                  if (isSelected) {
                                    currentSkills.add(skill);
                                  } else {
                                    currentSkills.remove(skill);
                                  }
                                  _selectedSkillsNotifier.value = currentSkills;
                                },
                                backgroundColor: Colors.teal[50],
                                selectedColor: Colors.teal[200],
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AdminBloc, AdminState>(
            listener: (context, state) {
              if (state is CreateMemberSuccess) {
                context.read<MemberBloc>().add(LoadMembers());
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is AdminLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate() &&
                      _selectedRoleNotifier.value != null &&
                      _selectedSkillsNotifier.value.isNotEmpty &&
                      _locationController.text.isNotEmpty) {
                    final user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      final member = Member(
                        id: user.uid,
                        name: _nameController.text,
                        role: _selectedRoleNotifier.value!,
                        mobile: _mobileController.text,
                        email: _emailController.text,
                        location: _locationController.text,
                        skills: _selectedSkillsNotifier.value,
                        profileUrl: _imageUrl,
                      );
                      context.read<AdminBloc>().add(
                        CreateMemberButtonPressed(member: member),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text(
                  'Create Member',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }
}
