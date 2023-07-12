import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AdoptionHistory {
  final String id;
  final String name;
  final int age;
  final String sex;
  final String imageUrl;
  final DateTime adoptedTime;

  AdoptionHistory({
    required this.id,
    required this.name,
    required this.age,
    required this.sex,
    required this.imageUrl,
    required this.adoptedTime,
  });

  factory AdoptionHistory.fromSnapshot(Map<String, dynamic> map, String id) {
    return AdoptionHistory(
      id: id,
      name: map['name'] as String,
      age: map['age'] as int,
      sex: map['sex'] as String,
      imageUrl: map['imageUrl'] as String,
      adoptedTime: (map['adoptedTime'] as Timestamp).toDate(),
    );
  }

  AdoptionHistory copyWith({
    String? id,
    String? name,
    int? age,
    String? sex,
    String? imageUrl,
    DateTime? adoptedTime,
  }) {
    return AdoptionHistory(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      imageUrl: imageUrl ?? this.imageUrl,
      adoptedTime: adoptedTime ?? this.adoptedTime,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
      'imageUrl': imageUrl,
      'adoptedTime': adoptedTime.millisecondsSinceEpoch,
    };
  }

  factory AdoptionHistory.fromMap(Map<String, dynamic> map) {
    return AdoptionHistory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age']?.toInt() ?? 0,
      sex: map['sex'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      adoptedTime: DateTime.fromMillisecondsSinceEpoch(map['adoptedTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AdoptionHistory.fromJson(String source) =>
      AdoptionHistory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdoptionHistory(id: $id, name: $name, age: $age, sex: $sex, imageUrl: $imageUrl, adoptedTime: $adoptedTime)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdoptionHistory &&
        other.id == id &&
        other.name == name &&
        other.age == age &&
        other.sex == sex &&
        other.imageUrl == imageUrl &&
        other.adoptedTime == adoptedTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        age.hashCode ^
        sex.hashCode ^
        imageUrl.hashCode ^
        adoptedTime.hashCode;
  }
}
