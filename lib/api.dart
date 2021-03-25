import 'package:http/http.dart' as http;
import 'dart:convert';

class Callback{

final _urlto="http://192.168.43.231:8000/api/";
final urltoimages="http://192.168.43.231:8000/storage/images/";

 _setHeaders()=>{
      'Accept':'application/json',
      'Content-type':'application/json'
  };

  postData(data,url) async
  {
    var fullurl=_urlto+url;
    return await http.post(
      fullurl,
      body:jsonEncode(data),
      headers:_setHeaders()
    );

  }

  getData(url) async
  {
    var fullurl=_urlto+url;
    return await http.get(
      fullurl,
      headers:_setHeaders()
    );
     
  }

}