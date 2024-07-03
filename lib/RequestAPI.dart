import 'dart:convert';

import 'package:intl/intl.dart';

import 'BoxOffice.dart';
import 'package:http/http.dart' as http;

import 'Keys.dart';



class RequestAPI {

  static const baseUrl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
  static String appKey = Keys.KOFIC_API_KEY;



  static Future<List<BoxOffice>> getTodaysBoxOffice() async {
    List<BoxOffice> boxofficeInstance = [];


    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    String formattedDate = DateFormat('yyyyMMdd').format(yesterday);

    //API 요청 = 주소/앱키/날짜(전일기준)
    final uri = Uri.parse('$baseUrl?key=$appKey&targetDt=$formattedDate');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      String showRange = jsonData["boxOfficeResult"]["showRange"];
      final List<dynamic> dailyBoxOfficeList = jsonData["boxOfficeResult"]["dailyBoxOfficeList"];
      for (var movieList in dailyBoxOfficeList) {
        final instance = BoxOffice.fromJson({
          ...movieList,
        'showRange' : showRange });
        boxofficeInstance.add(instance);
      }
      return boxofficeInstance;

    }
    throw Error();
  }
}