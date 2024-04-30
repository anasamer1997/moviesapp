// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'result_adapter.g.dart';

@HiveType(typeId: 0)
class ApiResponse extends HiveObject {
  @HiveField(0) //unique index of the field
  String url;

  @HiveField(1)
  String response;
  @HiveField(2)
  int timestamp;
  ApiResponse({
    required this.url,
    required this.response,
    required this.timestamp,
  });
}
