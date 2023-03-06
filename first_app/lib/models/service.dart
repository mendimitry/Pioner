import 'package:json_annotation/json_annotation.dart';
part 'service.g.dart';

@JsonSerializable()
class Service {
  final String name;
  final int value, time;
  bool? isChecked;

  Service({
    required this.name,
    required this.time,
    required this.value,
    this.isChecked
  });

  factory Service.fromJSON(Map<String, dynamic> data) => _$ServiceFromJson(data);

  Map<String, dynamic> toJson() => _$ServiceToJson(this);

}