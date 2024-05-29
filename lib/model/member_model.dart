import 'package:hive/hive.dart';

part 'member_model.g.dart';

class DataJKT48 {
  final List<Members>? members;
  final List<Events>? events;

  DataJKT48({
    this.members,
    this.events,
  });

  DataJKT48.fromJson(Map<String, dynamic> json)
      : members = (json['members'] as List?)
            ?.map((dynamic e) => Members.fromJson(e as Map<String, dynamic>))
            .toList(),
        events = (json['events'] as List?)
            ?.map((dynamic e) => Events.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'members': members?.map((e) => e.toJson()).toList(),
        'events': events?.map((e) => e.toJson()).toList()
      };
}

class Members extends HiveObject {
  final String? name;
  final String? dateOfBirth;
  final String? bloodType;
  final String? horoscope;
  final int? bodyHeight;
  final String? nickname;
  final String? photoUrl;
  final String? type;

  Members({
    this.name,
    this.dateOfBirth,
    this.bloodType,
    this.horoscope,
    this.bodyHeight,
    this.nickname,
    this.photoUrl,
    this.type,
  });

  Members.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        dateOfBirth = json['dateOfBirth'] as String?,
        bloodType = json['bloodType'] as String?,
        horoscope = json['horoscope'] as String?,
        bodyHeight = json['bodyHeight'] as int?,
        nickname = json['nickname'] as String?,
        photoUrl = json['photoUrl'] as String?,
        type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'dateOfBirth': dateOfBirth,
        'bloodType': bloodType,
        'horoscope': horoscope,
        'bodyHeight': bodyHeight,
        'nickname': nickname,
        'photoUrl': photoUrl,
        'type': type
      };
}

@HiveType(typeId: 1)
class Events extends HiveObject {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? time;
  @HiveField(2)
  String? price;
  @HiveField(3)
  String? nama;
  final String? photoUrl;
  final String? venue;

  Events(
      {this.name, this.photoUrl, this.venue, this.time, this.price, this.nama});

  Events.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        photoUrl = json['photoUrl'] as String?,
        venue = json['venue'] as String?,
        time = json['time'] as String?,
        price = json['price'] as String?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'photoUrl': photoUrl,
        'venue': venue,
        'time': time,
        'price': price
      };
}
