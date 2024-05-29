import 'package:hive/hive.dart';
import 'package:jkt48_app/model/member_model.dart';

part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String password;

  @HiveField(3)
  List<Events> eventHistory;

  User({
    required this.username,
    required this.password,
    required this.eventHistory,
  });

  get history => null;
}
