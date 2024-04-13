import 'package:flutter/material.dart';

import '../../../../res/strings.dart';
import '../../../services/auth.dart';
import '../home/home_view.dart';
import '../preferences/preferences_view.dart';
import '../schedule/schedule_view.dart';
import '../subjects/subjects_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavigationIndex = 0;
  final List<Widget> pages = const [HomePage(), SubjectsPage(), SchedulePage(), Preferences()];
  final List<String> title = const [Strings.home, Strings.subjects, Strings.schedule, Strings.preferences];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: Text(title[_bottomNavigationIndex]),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: theme.colorScheme.surface,
        child: ListView(
          children: <Widget>[
            // User details header
            UserAccountsDrawerHeader(
              accountEmail: Text(Auth.getUserEmail()),
              accountName: Text(Auth.getUserName()),
              currentAccountPicture: Icon(
                Icons.account_circle,
                size: 72.0,
                color: theme.colorScheme.onPrimary,
              ),
            ),

            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      OutlinedButton(
                        onPressed: () {
                          Auth.signOut();
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: theme.colorScheme.primary),
                        ),
                        child: const Text(Strings.signOut),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: theme.colorScheme.surface,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 64.0,
        selectedIndex: _bottomNavigationIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home_outlined), label: Strings.home),
          NavigationDestination(icon: Icon(Icons.my_library_books_outlined), label: Strings.subjects),
          NavigationDestination(icon: Icon(Icons.schedule_outlined), label: Strings.schedule),
          NavigationDestination(icon: Icon(Icons.more_horiz_outlined), label: Strings.more),
        ],
        onDestinationSelected: (selectedIndex) {
          setState(() {
            _bottomNavigationIndex = selectedIndex;
          });
        },
        indicatorColor: theme.colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: pages[_bottomNavigationIndex],
      ),
    );
  }
}
