// ignore_for_file: file_names

import 'package:hive/hive.dart';
part 'QuickTask.g.dart';

@HiveType(typeId: 1)
class QuickTask {
  QuickTask(
      {this.id,
      this.taskNo,
      this.tasktitle,
      this.taskdetails,
      this.taskcreatedAt});
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? taskNo;
  @HiveField(2)
  String? tasktitle;
  @HiveField(3)
  String? taskdetails;
  @HiveField(4)
  String? taskcreatedAt;
}
