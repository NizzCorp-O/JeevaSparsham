import 'package:flutter/material.dart';

class CenterNameField extends StatelessWidget {
  final TextEditingController centerNameController;
  const CenterNameField({super.key, required this.centerNameController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Center Name', style: Theme.of(context).textTheme.labelLarge),
        SizedBox(height: 10),
        TextFormField(
          controller: centerNameController,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name is required';
            } else if (value.trim().length < 3) {
              return 'Name must be at least 3 characters';
            }
            return null;
          },
          decoration: InputDecoration(hintText: 'Enter center name'),
        ),
        SizedBox(height: 7),
        Text(
          'Minimum 3 characters required',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
