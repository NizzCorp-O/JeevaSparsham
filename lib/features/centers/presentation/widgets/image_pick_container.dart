import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/core/app_snackbar.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';

class ImagePickContainer extends StatelessWidget {
  const ImagePickContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: AppColors.borderPrimary,
        strokeWidth: 2,
        dashPattern: [2, 2],
        radius: Radius.circular(8),
      ),
      child: Container(
        width: screenWidth * 0.9,
        height: screenHeight * 0.188,
        decoration: BoxDecoration(
          color: Color.fromRGBO(249, 247, 244, 0.5),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: InkWell(
          onTap: () {
            context.read<CenterBloc>().add(PickImageFromGallery());
          },
          child: BlocConsumer<CenterBloc, CenterState>(
            listener: (context, state) {
              if (state is ImagePickFailure) {
                AppSnackbar.show(context, message: state.message);
              }
            },
            builder: (context, state) {
              if (state is ImagePicked) {
                return Image.file(
                  File(state.imagePath),
                  width: 200,
                  height: 200,
                  fit: BoxFit.fitWidth,
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 48,
                      height: 48,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Upload Image / Take Photo',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Choose from camera or gallery',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Color.fromRGBO(170, 183, 184, 1),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
