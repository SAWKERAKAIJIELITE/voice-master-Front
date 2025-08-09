import 'package:flutter/material.dart';

class PersonAvatar extends StatelessWidget {
  const PersonAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      child: Icon(
        Icons.person,
        color: Colors.white,
      ),
    );
  }
}
