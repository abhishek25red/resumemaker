 final String cvtable = 'cvs';

class cvsFields {
  static final List<String> values = [
    id, liked, mnumber, title, address,skills,edu, time
  ];

  static final String id = '_id';
  static final String liked = 'liked';
  static final String mnumber = 'mobilenumber';
  static final String title = 'title';
  static final String fullname = 'fullname';
  static final String address = 'address';
  static final String skills = 'skills';
  static final String edu = 'education';
  static final String time = 'time';
}

class cv {
  final int? id;
  final bool liked;
  final int mnumber;
  final String title;
  final String fullname;
  final String address;
  final String skills;
  final String edu;
  final DateTime createdTime;

  const cv({
    this.id,
    required this.liked,
    required this.mnumber,
    required this.title,
    required this.fullname,
    required this.address,
    required this.skills,
    required this.edu,
    required this.createdTime,
  });

  cv copy({
    int? id,
    bool? liked,
    int? mnumber,
    String? title,
    String? fullname,
    String? address,
    String? skills,
    String? edu,
    DateTime? createdTime,
  }) =>
      cv(
        id: id ?? this.id,
        liked: liked ?? this.liked,
        mnumber: mnumber ?? this.mnumber,
        title: title ?? this.title,
        fullname: fullname ?? this.fullname,
        address: address ?? this.address,
        skills: skills ?? this.skills,
        edu: edu ?? this.edu,
        createdTime: createdTime ?? this.createdTime,
      );

  static cv fromJson(Map<dynamic, dynamic?> json) => cv(
    id: json[cvsFields.id] as int?,
    liked: json[cvsFields.liked] == 1,
    mnumber: json[cvsFields.mnumber] as int,
    title: json[cvsFields.title] as String,
    fullname: json[cvsFields.fullname] as String,
    address: json[cvsFields.address] as String,
    skills: json[cvsFields.skills] as String,
    edu: json[cvsFields.edu] as String,
    createdTime: DateTime.parse(json[cvsFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    cvsFields.id: id,
    cvsFields.title: title,
    cvsFields.fullname: fullname,
    cvsFields.liked: liked ? 1 : 0,
    cvsFields.mnumber: mnumber,
    cvsFields.address: address,
    cvsFields.skills: skills,
    cvsFields.edu: edu,
    cvsFields.time: createdTime.toIso8601String(),
  };
}