import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import '../../widgets/subjects/subject_list_tile.dart';
import 'subjects_viewmodel.dart';

class SubjectsView extends StatefulWidget {
  const SubjectsView({super.key});

  @override
  State<SubjectsView> createState() => _SubjectsViewState();
}

class _SubjectsViewState extends State<SubjectsView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SubjectsViewModel>.reactive(
      disposeViewModel: false,
      viewModelBuilder: () => locator<SubjectsViewModel>(),
      builder: (BuildContext context, SubjectsViewModel viewModel, Widget? child) => Scaffold(
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
              hasScrollBody: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: FutureBuilder(
                        future: viewModel.initialize(),
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
                            value: viewModel.dropDownValue,
                            borderRadius: BorderRadius.circular(8.0),
                            items: viewModel.list.map<DropdownMenuItem<String>>((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(viewModel.semName[item] ?? item.toString()),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                viewModel.dropDownValue = value!;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    FutureBuilder(
                      future: viewModel.updateSubjects(setState),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return Column(
                          children: <Widget>[
                            for (var sub in viewModel.subjectList)
                              if (viewModel.isStudent)
                                SubjectListTile(
                                  title: sub.title,
                                  assignments: sub.assignmentCount,
                                  forStudent: viewModel.isStudent,
                                )
                              else
                                SubjectListTile(
                                  title: sub.title,
                                  assignments: sub.assignmentCount,
                                  forStudent: viewModel.isStudent,
                                  course: sub.courseShort(),
                                  department: sub.departmentShort(),
                                ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
