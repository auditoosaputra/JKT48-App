class DataMember {
  final List<Members>? members;

  DataMember({
    this.members,
  });

  DataMember.fromJson(Map<String, dynamic> json)
      : members = (json['members'] as List?)
            ?.map((dynamic e) => Members.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'members': members?.map((e) => e.toJson()).toList()};
}

class Members {
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
