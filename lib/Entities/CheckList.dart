import 'Check.dart';

class CheckList {
  List<Check> checkList;

  CheckList(this.checkList);

  CheckList.fromJson(Map<String, dynamic> json)
      : checkList = json['checkItems'] != null
            ? List<Check>.from(json['checkItems'])
            : null;

  Map<String, dynamic> toJson() => {'checkItems': checkList};
}
