import 'package:edu/models/crypto_model/all_crypto_model.dart';
import 'package:edu/network/api_provider.dart';
import 'package:edu/network/respnse_model.dart';
import 'package:flutter/cupertino.dart';

class MarketViewProvider extends ChangeNotifier {
  ApiProvider apiProvider = ApiProvider();
  late AllCryptoModel dataFuture;
  late ResponseModel state;
  var response;

  getCryptoData() async {
    // start loading api
    state = ResponseModel.loading("is loading...");
    // notifyListeners();
    print('loding');
    try {
      response = await apiProvider.getAllCryptoData();
      if (response.statusCode == 200) {
        dataFuture = AllCryptoModel.fromJson(response.data);
        state = ResponseModel.completed(dataFuture);
      } else {
        state = ResponseModel.error("something wrong please try again...");
      }
      notifyListeners();
    } catch (e) {
      state = ResponseModel.error("please check your connection...");
      notifyListeners();

      print(e.toString());
    }
  }
}
