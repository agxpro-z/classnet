// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:flutter/material.dart';

class TitleLoading extends StatelessWidget {
  const TitleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 128,
            child: Container(
              height: 32.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.0),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
