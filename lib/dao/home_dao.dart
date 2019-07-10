import 'package:dio/dio.dart';
import 'package:flutter_yjh/models/entity_factory.dart';
import 'dart:async';

import 'package:flutter_yjh/models/store_entity.dart';

import 'config.dart';



const HOME_URL = '$SERVER_HOST/api/store';


class HomeDao{

  static Future<StoreEntity> fetch() async{
    try {
      Response response = await Dio().get(HOME_URL);

      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<StoreEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}




