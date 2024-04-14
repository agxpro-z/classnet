import 'package:flutter/material.dart';

import '../../../../res/strings.dart';
import '../../../services/auth.dart';

class NavigationViewDrawer extends StatelessWidget {
  const NavigationViewDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
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
    );
  }
}
