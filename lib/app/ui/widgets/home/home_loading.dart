// Copyright 2024 agxpro.dev
// Author: Ankit Gourav (agxpro)

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../subjects/subject_list_tile_loading.dart';
import 'assignment_card_loading.dart';
import 'title_loading.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final Color baseColor = brightness == Brightness.light ? Colors.grey.shade300 : Colors.grey.shade800;
    final Color highlightColor = brightness == Brightness.light ? Colors.grey.shade100 : Colors.grey.shade700;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            enabled: true,
            child: const Column(
              children: <Widget>[
                TitleLoading(),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    AssignmentCardLoading(),
                    SizedBox(width: 8.0),
                    AssignmentCardLoading(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            enabled: true,
            child: const Column(
              children: <Widget>[
                TitleLoading(),
                SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    AssignmentCardLoading(),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            enabled: true,
            child: const Column(
              children: <Widget>[
                TitleLoading(),
                SizedBox(height: 12.0),
                SubjectListTileLoading(),
                SizedBox(height: 16.0),
                SubjectListTileLoading(),
                SizedBox(height: 16.0),
                SubjectListTileLoading(),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
        ],
      ),
    );
  }
}
