import 'package:cinema_db/core/base_entity.dart';

class RegisterMovieResponseModel extends BaseEntity<bool> {
  const RegisterMovieResponseModel({
    required bool success,
    required String code,
    required String version,
    required bool data,
  }) : super(
          code: code,
          success: success,
          version: version,
          data: data,
        );

  factory RegisterMovieResponseModel.fromJson(Map<String, dynamic> map) {
    final response = RegisterMovieResponseModel(
      success: map['success'],
      code: map['code'],
      version: map['version'],
      data: true,
    );
    return response;
  }

  @override
  List<Object> get props => [
        success,
        code,
        version,
        data,
      ];
}
