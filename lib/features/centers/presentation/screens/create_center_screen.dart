import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/create_center_form.dart';
import 'package:hello_pratice/features/centers/presentation/widgets/image_pick_container.dart';

class CreateCenterScreen extends StatelessWidget {
  const CreateCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Create Center',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 20),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(color: AppColors.borderPrimary, thickness: 1),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Center Image',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(fontSize: 16),
            ),
            SizedBox(height: 20),
            ImagePickContainer(),
            SizedBox(height: 50),
            CreateCenterForm(),
          ],
        ),
      ),
    );
  }
}
