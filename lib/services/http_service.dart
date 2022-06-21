import 'dart:developer';

import 'package:simpleflutter/models/summary_model.dart';
import 'package:http/http.dart' as http;
import 'package:simpleflutter/services/constants.dart';

class HttpService {
  Future<SummaryModel?> getCovidSummary() async {
    try {
      var url = Uri.parse(Constants.baseUrl + Constants.summary);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        SummaryModel? result = summaryModelFromJson(response.body);
        return result;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
