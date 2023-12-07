import 'package:dio/dio.dart';
import 'package:leitor_ebooks/src/service/dio_service.dart';

class DioServiceImp implements DioService {
  @override
  Dio getDio() {
    return Dio();
  }
}
