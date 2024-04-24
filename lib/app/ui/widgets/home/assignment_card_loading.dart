// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:flutter/material.dart';

class AssignmentCardLoading extends StatelessWidget {
  const AssignmentCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Card(
            color: Colors.grey,
            margin: EdgeInsets.all(0.0),
            child: SizedBox(
              height: 144,
              width: 164,
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 128,
            child: Container(
              height: 16.0,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 148,
            child: Container(
              height: 16.0,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 96,
            child: Container(
              height: 14.0,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
