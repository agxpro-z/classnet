import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../i18n/strings.g.dart';
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
      onViewModelReady: (viewModel) => viewModel.initialize(),
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
                      title: Text(t.preferencesView.logOut),
                      content: Text(t.preferencesView.logOutMsg),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(t.cancel),
                        ),
                        FilledButton(
                          onPressed: () {
                            Auth.signOut();
                            Navigator.of(context).pop();
                          },
                          child: Text(t.preferencesView.logOut),
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
            SliverFillRemaining(
              hasScrollBody: true,
              child: viewModel.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : (viewModel.isStudent)
                      ? Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                t.preferencesView.course,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: const Icon(Icons.school_rounded),
                              subtitle: Text(
                                viewModel.managerAPI.getCourse().name,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                t.preferencesView.branch,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: const Icon(Icons.vertical_split_rounded),
                              subtitle: Text(
                                viewModel.managerAPI.getCourse().branch,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                t.preferencesView.department,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: const Icon(Icons.account_balance_rounded),
                              subtitle: Text(
                                viewModel.managerAPI.getCourse().department,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                t.preferencesView.semesters,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: const Icon(Icons.horizontal_split_rounded),
                              subtitle: Text(
                                viewModel.managerAPI.getCourse().semList.length.toString(),
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                t.preferencesView.department,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: const Icon(Icons.account_balance_rounded),
                              subtitle: Text(
                                viewModel.user!.department,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
