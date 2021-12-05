import 'package:equatable/equatable.dart';

class BaseEntity<T> extends Equatable {
  const BaseEntity({
    required this.success,
    required this.code,
    required this.version,
    required this.data,
  });

  final bool success;
  final String code;
  final String version;
  final T data;

  @override
  List<dynamic> get props => [success, code, version, data];
}
