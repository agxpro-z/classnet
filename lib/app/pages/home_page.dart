import 'package:flutter/material.dart';

import '../../res/values/strings.dart';
import '../auth/auth.dart';
import '../components/assignment_card.dart';
import '../components/subjects.dart';

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
      backgroundColor: theme.colorScheme.surface,
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
          )),
      bottomNavigationBar: NavigationBar(
        backgroundColor: theme.colorScheme.surface,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 64.0,
        selectedIndex: _bottomNavigationIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home_outlined), label: Strings.home),
          NavigationDestination(icon: Icon(Icons.my_library_books_outlined), label: Strings.assignments),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Strings.upcomingAssignments,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: theme.textTheme.titleMedium?.fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    AssignmentCard(
                      deadline: "Today, 11:59",
                      title: "Assignment 2 & 3",
                      subject: "KE Lab",
                    ),
                    AssignmentCard(
                      deadline: "Tomorrow, 11:59",
                      title: "Task 1 Tcases",
                      subject: "Software Testing",
                    ),
                    AssignmentCard(
                      deadline: "Tomorrow, 11:59",
                      title: "Task 1 Tcases",
                      subject: "Software Testing",
                    ),
                    AssignmentCard(
                      deadline: "Tomorrow, 11:59",
                      title: "Task 1 Tcases",
                      subject: "Software Testing",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Strings.notGradedAssignments,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: theme.textTheme.titleMedium?.fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    AssignmentCard(
                      deadline: "Today, 11:59",
                      title: "Assignment 2 & 3",
                      subject: "KE Lab",
                    ),
                    AssignmentCard(
                      deadline: "Tomorrow, 11:59",
                      title: "Task 1 Tcases",
                      subject: "Software Testing",
                    ),
                    AssignmentCard(
                      deadline: "Tomorrow, 11:59",
                      title: "Task 1 Tcases",
                      subject: "Software Testing",
                    ),
                    AssignmentCard(
                      deadline: "Tomorrow, 11:59",
                      title: "Task 1 Tcases",
                      subject: "Software Testing",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  Strings.allSubjects,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: theme.textTheme.titleMedium?.fontSize,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const Subjects(),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}
