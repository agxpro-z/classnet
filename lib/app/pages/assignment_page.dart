import 'package:flutter/material.dart';

import '../../res/values/strings.dart';
import '../components/subjects.dart';
import '../providers/course.dart';

class AssignmentPage extends StatefulWidget {
  const AssignmentPage({super.key});

  @override
  State<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<AssignmentPage> {
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

  Future<void> updateSemList() async {
    CourseProvider courseProvider = CourseProvider();
    if (_semList.length > 1) {
      return;
    }

    final semList = await courseProvider.getSemList();

    if (semList.isNotEmpty) {
      _semList = semList;

      setState(() {
        _dropDownValue = _semList.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: updateSemList(),
          builder: (context, snapshot) {
            return DropdownButton<String>(
              isExpanded: true,
              dropdownColor: Theme.of(context).colorScheme.surface,
              elevation: 4,
              value: _dropDownValue,
              borderRadius: BorderRadius.circular(8.0),
              items: _semList.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(_semName[item] ?? Strings.invalidSemester),
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
        Expanded(
          child: SingleChildScrollView(
            child: Subjects(sem: _dropDownValue),
          ),
        ),
      ],
    );
  }
}
