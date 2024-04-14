import 'package:flutter/material.dart';

import '../../../../res/strings.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({super.key});

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            isMainView: true,
            title: Text(
              Strings.preferences,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(Strings.preferences),
            ),
          ),
        ],
      ),
    );
  }
}
