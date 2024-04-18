import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../res/strings.dart';
import '../../../app.locator.dart';
import '../../widgets/shared/custom_sliver_app_bar.dart';
import '../../widgets/subjects/subject_list_tile.dart';
import '../assignments/assignments_view.dart';
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
      onViewModelReady: (viewModel) => viewModel.initialize(),
      builder: (BuildContext context, SubjectsViewModel viewModel, Widget? child) => Scaffold(
        body: RefreshIndicator(
          onRefresh: () => viewModel.forceUpdateSubjects(),
          child: CustomScrollView(
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
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: DropdownButton<String>(
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
                        ),
                      ),
                      Expanded(
                        child: FutureBuilder(
                          future: viewModel.updateSubjects(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(child: CircularProgressIndicator());
                            } else if (viewModel.subjectList.isEmpty) {
                              return const Center(child: Text(Strings.noSubjects));
                            }
                            return Column(
                              children: <Widget>[
                                for (var sub in viewModel.subjectList)
                                  if (viewModel.isStudent)
                                    GestureDetector(
                                      onTap: () => sub.assignmentCount == 0
                                          ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: const Text(Strings.noAssignments),
                                              backgroundColor: Colors.yellow[800],
                                            ))
                                          : Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => AssignmentsView(
                                                title: sub.title,
                                                subject: sub,
                                              ),
                                            )),
                                      child: SubjectListTile(
                                        title: sub.title,
                                        assignments: sub.assignmentCount,
                                        forStudent: viewModel.isStudent,
                                      ),
                                    )
                                  else
                                    GestureDetector(
                                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => AssignmentsView(
                                          title: sub.title,
                                          subject: sub,
                                        ),
                                      )),
                                      child: SubjectListTile(
                                        title: sub.title,
                                        assignments: sub.assignmentCount,
                                        forStudent: viewModel.isStudent,
                                        course: sub.courseShort(),
                                        department: sub.departmentShort(),
                                      ),
                                    ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
