import 'package:flutter_dust/models/air_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';

class AirBloc {

  final _airSubject = BehaviorSubject<AirResult>();

  AirBloc(){
    fetch();
  }

  Future<AirResult> fetchData() async {
    var url = Uri.parse(
        'https://api.airvisual.com/v2/nearest_city?key=2905a9a0-8a88-4178-bf53-60bbf9d9385b');
    var response = await http.get(url);

    AirResult result = AirResult.fromJson(json.decode(response.body));

    return result;
  }


  void fetch() async {
    print('fetch');
    var airResult = await fetchData();
    _airSubject.add(airResult);
  }

  Stream<AirResult> get airResult => _airSubject.stream;

}

// _result?.data?.current == null
// ? CircularProgressIndicator()
//     :