import 'package:dio/dio.dart';

enum Status {
  Success,
  Loading,
  NetworkError,
  Error,
}

const String url = 'https://opentdb.com/api.php?amount=10&type=multiple';

class ApiProvider {
  // for all get request
  static Future get() async {
    var dio = Dio();
    var _response;

    // if (!await Connection.isConnected()) {
    //   return {'status': 'No Connection', 'body': 'No Internet Connection'};
    // }

    try {
      _response = await dio.get(
        url,
        // queryParameters: {'amount': 10, 'type': 'multiple'}
      );

      return {'status': _response.statusCode, 'body': _response.data};
    } on DioError catch (e) {
      return {'status': e.response?.statusCode, 'body': e.response?.data};
    }
  }

  // for all post request

}
