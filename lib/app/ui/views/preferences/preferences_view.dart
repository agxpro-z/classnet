import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../../services/auth.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import 'preferences_viewmodel.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({super.key});

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PreferencesViewModel>.reactive(
      disposeViewModel: false,
      fireOnViewModelReadyOnce: true,
      viewModelBuilder: () => locator<PreferencesViewModel>(),
      builder: (BuildContext context, PreferencesViewModel viewModel, Widget? child) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            CustomSliverAppBar(
              isMainView: true,
              actions: <Widget>[
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(Strings.signOut),
                      content: const Text(Strings.signOutMsg),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text(Strings.signOutCancel),
                        ),
                        FilledButton(
                          onPressed: () {
                            Auth.signOut();
                            Navigator.of(context).pop();
                          },
                          child: const Text(Strings.signOut),
                        ),
                      ],
                    ),
                  ),
                  icon: const Icon(Icons.logout),
                ),
              ],
              title: Row(
                children: <Widget>[
                  const Icon(Icons.account_circle),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        viewModel.getUserName().toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                        ),
                      ),
                      Text(
                        viewModel.getUserEmail().toString(),
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.labelSmall?.fontSize,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                children: <Widget>[],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
