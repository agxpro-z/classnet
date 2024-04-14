import 'package:injectable/injectable.dart';

@lazySingleton
class Assignment {
  Assignment({
    required this.title,
    required this.description,
    required this.creator,
    required this.points,
    required this.createdOn,
  });

  String title;
  String description;
  String creator;
  int points;
  DateTime createdOn;
}
