import 'package:dio/dio.dart';

import '../restful/rest_utility.dart';

abstract class BaseService {
  late RestUtils rest;
  CancelToken? cancel;
  BaseService(RestUtils restUtils, {CancelToken? cancelToken}) {
    rest = restUtils;
    cancel = cancelToken;
  }
}
