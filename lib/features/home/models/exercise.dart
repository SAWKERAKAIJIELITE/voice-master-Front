class ExerciseModel {
  ExerciseModel({
      this.exercise, 
      this.correctPronounceFile,});

  ExerciseModel.fromJson(dynamic json) {
    exercise = json['exercise'] != null ? Exercise.fromJson(json['exercise']) : null;
    correctPronounceFile = json['correct_pronounce_file'];
  }
  Exercise? exercise;
  String? correctPronounceFile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (exercise != null) {
      map['exercise'] = exercise?.toJson();
    }
    map['correct_pronounce_file'] = correctPronounceFile;
    return map;
  }

}

class Exercise {
  Exercise({
      this.id, 
      this.text, 
      this.mistakes, 
      this.createdAt, 
      this.updatedAt, 
      this.user,});

  Exercise.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'] != null ? TextModel.fromJson(json['text']) : null;
    if (json['mistakes'] != null) {
      mistakes = [];
      json['mistakes'].forEach((v) {
        mistakes?.add(Mistakes.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
  }
  int? id;
  TextModel? text;
  List<Mistakes>? mistakes;
  String? createdAt;
  String? updatedAt;
  int? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (text != null) {
      map['text'] = text?.toJson();
    }
    if (mistakes != null) {
      map['mistakes'] = mistakes?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['user'] = user;
    return map;
  }

}

class Mistakes {
  Mistakes({
      this.position, 
      this.type,});

  Mistakes.fromJson(dynamic json) {
    position = json['position'];
    type = json['type'];
  }
  int? position;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['position'] = position;
    map['type'] = type;
    return map;
  }

}

class TextModel {
  TextModel({
      this.id, 
      this.text, 
      this.correctPronounceFilePath, 
      this.createdAt,});

  TextModel.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'];
    correctPronounceFilePath = json['correct_pronounce_file_path'];
    createdAt = json['created_at'];
  }
  int? id;
  String? text;
  String? correctPronounceFilePath;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['text'] = text;
    map['correct_pronounce_file_path'] = correctPronounceFilePath;
    map['created_at'] = createdAt;
    return map;
  }

}