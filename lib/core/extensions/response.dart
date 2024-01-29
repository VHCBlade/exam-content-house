import 'package:mobile_exam/core/services/server.dart';

/// Helper class to more easily interact with responses from the [Server]
class ServerResponse {
  ServerResponse(this.baseRequest) {
    assert(baseRequest['status_code'] is int,
        'All Server Responses must have a valid "status_code!"');
    statusCode = baseRequest['status_code'];
  }

  String? get imageLink => baseRequest['image'] as String?;
  String? get message => baseRequest['message'] as String?;
  int? get count => baseRequest['count'] as int?;
  String? get errorMessage => baseRequest['error_message'] as String?;

  final Map<String, dynamic> baseRequest;

  late final int statusCode;
  bool get hasError => statusCode != 200;
}
