// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) => Service(
      name: json['name'] as String,
      time: json['time'] as int,
      value: json['value'] as int,
      isChecked: json['isChecked'] as bool?,
    );

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'time': instance.time,
      'isChecked': instance.isChecked,
    };
