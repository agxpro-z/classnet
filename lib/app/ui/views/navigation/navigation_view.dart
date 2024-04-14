import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../widgets/navigationView/drawer.dart';
import 'navigation_viewmodel.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ViewModelBuilder<NavigationViewModel>.reactive(
      viewModelBuilder: () => locator<NavigationViewModel>(),
      builder: (BuildContext context, NavigationViewModel viewModel, Widget? child) => Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surface,
          title: Text(viewModel.getViewName()),
          centerTitle: true,
        ),
        drawer: const NavigationViewDrawer(),
        bottomNavigationBar: NavigationBar(
          backgroundColor: theme.colorScheme.surface,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 64.0,
          selectedIndex: viewModel.currentIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: viewModel.isIndexSelected(0) ? const Icon(Icons.home) : const Icon(Icons.home_outlined),
              label: Strings.home,
            ),
            NavigationDestination(
              icon: viewModel.isIndexSelected(1) ? const Icon(Icons.my_library_books) : const Icon(Icons.my_library_books_outlined),
              label: Strings.subjects,
            ),
            NavigationDestination(
              icon: viewModel.isIndexSelected(2) ? const Icon(Icons.schedule) : const Icon(Icons.schedule_outlined),
              label: Strings.schedule,
            ),
            NavigationDestination(
              icon: viewModel.isIndexSelected(3) ? const  Icon(Icons.more_horiz) : const Icon(Icons.more_horiz_outlined),
              label: Strings.more,
            ),
          ],
          onDestinationSelected: viewModel.setIndex,
          indicatorColor: theme.colorScheme.inversePrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: viewModel.getViewForIndex(viewModel.currentIndex),
        ),
      ),
    );
  }
}
