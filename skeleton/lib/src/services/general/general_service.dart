// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../app_dependency.dart';
import '../../base/restful/rest_utility.dart';
import '../../base/services/base_service.dart';
import '../../common/app_config.dart';
import '../../common/constants.dart';
import '../../preferences/user_preference.dart';

abstract class GeneralService extends BaseService {
  GeneralService(super.restUtils);

  Future<void> uploadFile(List<XFile> files, String id, String api);
}

class GeneralServiceImpl extends GeneralService {
  GeneralServiceImpl(super.restUtils);

  @override
  Future<void> uploadFile(List<XFile> files, String? id, String api) async {
    final pref = AppDependencies.injector.get<UserPreference>();
    final config = AppDependencies.injector.get<AppConfig>();
    final String accessToken =
        await pref.getValue(UserSharedPreferencesPath.token) ?? '';

    var request =
        http.MultipartRequest('POST', Uri.parse('${config.baseUrlApi}$api'));
    request.headers.putIfAbsent('Authorization', () => 'Bearer $accessToken');

    for (var file in files) {
      final addFile = await http.MultipartFile.fromPath('files', file.path,
          filename: file.name, contentType: MediaType('image', 'jpeg'));
      request.files.add(addFile);
      var fields = <String, dynamic>{};
      fields.putIfAbsent('id', () => id);
      fields.forEach((k, v) => request.fields[k] = v);
    }

    var streamedResponse =
        await request.send().timeout(const Duration(minutes: 1));
    await http.Response.fromStream(streamedResponse);
  }
}
