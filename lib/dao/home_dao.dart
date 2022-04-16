import 'package:dio/dio.dart';
import 'package:flutter_yjh/models/entity_factory.dart';
import 'dart:async';

import 'package:flutter_yjh/models/store_entity.dart';

import 'config.dart';


class HomeDao{

  static Future<StoreEntity?> fetch() async{
    try {
      Response response = await Dio().get(HomeUrl);

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




