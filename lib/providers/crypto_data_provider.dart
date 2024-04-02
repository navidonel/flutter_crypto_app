import 'package:edu/models/crypto_model/all_crypto_model.dart';
import 'package:edu/network/api_provider.dart';
import 'package:edu/network/respnse_model.dart';
import 'package:flutter/material.dart';

class CryptoDataProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getAllMarketData() async {
    state = ResponseModel.loading("is loding");
    try{
      response = await apiProvider.getTopMarketCapData();
      print(response.statusCode);
      if(response.statusCode == 200){

        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("error");
      }

      notifyListeners();
    }catch(e){
      state = ResponseModel.error("check connction");
      notifyListeners();
    }
  }

  getTopMarketCapData() async {
    state = ResponseModel.loading("is loding");
    try{
      response = await apiProvider.getTopMarketCapData();
      print(response.statusCode);
      if(response.statusCode == 200){

        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("error");
      }

      notifyListeners();
    }catch(e){
      state = ResponseModel.error("check connction");
      notifyListeners();
    }
  }
  getTopGainerData() async {
    state = ResponseModel.loading("is loding");
    try{
      response = await apiProvider.getTopGainerData();
      print(response.statusCode);
      if(response.statusCode == 200){

        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("error");
      }

      notifyListeners();
    }catch(e){
      state = ResponseModel.error("check connction");
      notifyListeners();
    }
  }
  getTopLosersData() async {
    state = ResponseModel.loading("is loding");
    try{
      response = await apiProvider.getTopLosersData();
      print(response.statusCode);
      if(response.statusCode == 200){

        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      }else{
        state = ResponseModel.error("error");
      }

      notifyListeners();
    }catch(e){
      state = ResponseModel.error("check connction");
      notifyListeners();
    }
  }
}
