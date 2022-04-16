import 'package:dio/dio.dart';
import 'package:flutter_yjh/models/entity_factory.dart';
import 'dart:async';

import 'package:flutter_yjh/models/goods_entity.dart';

import 'config.dart';



class FindingsDao{

  static Future<GoodsEntity?> fetch() async{
    try {
      Response response = await Dio().get(FindingUrl);

      if(response.statusCode == 200){
        return EntityFactory.generateOBJ<GoodsEntity>(response.data);
      }else{
        throw Exception("StatusCode: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

}