import 'package:flutter/material.dart';
import 'package:hello_pratice/core/app_colors.dart';

class CenterPhoneField extends StatelessWidget {
  final TextEditingController phoneNumberController;
  const CenterPhoneField({super.key, required this.phoneNumberController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone Number', style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: 10),
        TextFormField(
          controller: phoneNumberController,
          decoration: InputDecoration(
            hintText: '+91-XXXXX-XXXXX',
            prefixIcon: Icon(Icons.call, color: AppColors.primary),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Phone number is required';
            }

            final regex = RegExp(r'^(?:\+91[-\s]?)?[0-9]{10}$');

            if (!regex.hasMatch(value.trim())) {
              return 'Enter a valid phone number';
            }

            return null;
          },
        ),
        SizedBox(height: 7),
        Text(
          'Enter a valid phone number',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
