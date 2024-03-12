import 'package:flutter/material.dart';

import '../../res/values/strings.dart';
import '../auth/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        title: const Text(Strings.home),
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
                          side: BorderSide(
                            color: theme.colorScheme.primary
                          )
                        ),
                        child: const Text(
                          Strings.signOut
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        )
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: theme.colorScheme.surface,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 64.0,
        selectedIndex: _bottomNavigationIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home_filled), label: Strings.home),
          NavigationDestination(icon: Icon(Icons.calendar_today), label: Strings.tasks),
          NavigationDestination(icon: Icon(Icons.my_library_books_outlined), label: Strings.library),
        ],
        onDestinationSelected: (selectedIndex) {
          setState(() {
            _bottomNavigationIndex = selectedIndex;
          });
        },
        indicatorColor: theme.colorScheme.inversePrimary,
      ),
    );
  }
}
