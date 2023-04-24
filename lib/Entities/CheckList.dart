import 'package:checkit/Entities/Check.dart';

class CheckList {
  List<Check> checks;

  CheckList({this.checks});

  CheckList.fromJson(Map<String, dynamic> json) : checks = json['checks'];

  Map<String, dynamic> toJson() => {'checks': checks};
}
