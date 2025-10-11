import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/application/bloc/center_bloc.dart';

class ImagePickContainer extends StatelessWidget {
  const ImagePickContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    // ignore: deprecated_member_use
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: AppColors.borderPrimary,
        strokeWidth: 2,
        dashPattern: [2, 2],
        radius: Radius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        onTap: () {
          context.read<CenterBloc>().add(PickImageFromGallery());
        },
        child: Container(
          width: screenWidth * 0.9,
          height: screenHeight * 0.188,
          decoration: BoxDecoration(
            color: Color.fromRGBO(249, 247, 244, 0.5),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: BlocBuilder<CenterBloc, CenterState>(
            buildWhen: (previous, current) => current is ImagePicked,
            builder: (context, state) {
              if (state is ImagePicked) {
                return Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
    
                  child: Image.file(File(state.imagePath), fit: BoxFit.cover),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/gallery.png'),
                    SizedBox(height: 10),
                    Text(
                      'Upload Image / Take Photo',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Choose from camera or gallery',
                      style: Theme.of(context).textTheme.bodySmall,
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
