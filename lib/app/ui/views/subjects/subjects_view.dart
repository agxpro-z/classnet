import 'package:flutter/material.dart';

import '../../../../res/strings.dart';
import '../../../services/auth.dart';
import '../../../providers/ay.dart';
import '../../../providers/course.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import '../../widgets/subjects/teacher_subjects.dart';
import '../../widgets/subjects/subjects.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  List<String> _semList = <String>[Strings.semester];
  late String _dropDownValue = _semList.first;

  final Map<String, String> _semName = {
    "sem1": Strings.sem1,
    "sem2": Strings.sem2,
    "sem3": Strings.sem3,
    "sem4": Strings.sem4,
    "sem5": Strings.sem5,
    "sem6": Strings.sem6,
    "sem7": Strings.sem7,
    "sem8": Strings.sem8,
  };

  Widget subjects() {
    String email = Auth.getUserEmail();

    if (email.contains('student')) {
      return Subjects(course: 'mca22', sem: _dropDownValue);
    } else {
      return TeacherSubjects(email: email, ay: _dropDownValue);
    }
  }

  Future<void> updateSemList() async {
    if (_semList.length > 1) {
      return;
    }

    CourseProvider courseProvider = CourseProvider();
    AYProvider ayProvider = AYProvider();
    String email = Auth.getUserEmail();
    List<String> list;

    if (email.contains('student')) {
      list = await courseProvider.getSemList();
    } else {
      list = await ayProvider.getAYList('faculty', email.split('@')[0]);
    }

    if (list.isNotEmpty) {
      _semList = list;

      setState(() {
        _dropDownValue = _semList.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(
            isMainView: true,
            title: Text(
              Strings.subjects,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: FutureBuilder(
                      future: updateSemList(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const Center(
                            child: Text('Loading...'),
                          );
                        }
                        return DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: Theme.of(context).colorScheme.surface,
                          elevation: 4,
                          value: _dropDownValue,
                          borderRadius: BorderRadius.circular(8.0),
                          items: _semList.map<DropdownMenuItem<String>>((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(_semName[item] ?? item.toString()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _dropDownValue = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    child: subjects(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
