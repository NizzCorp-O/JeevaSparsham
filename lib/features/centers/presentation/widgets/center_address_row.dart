import 'package:flutter/material.dart';

class CenterAddressRow extends StatelessWidget {
  final String location;
  const CenterAddressRow(this.location,{super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: Color.fromRGBO(93, 173, 226, 1)),
        SizedBox(width: 10),
        Expanded(
          child: Text(
           location,
            maxLines: 2,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
