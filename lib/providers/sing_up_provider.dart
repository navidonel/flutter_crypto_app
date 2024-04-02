import 'package:edu/network/api_provider.dart';
import 'package:edu/network/respnse_model.dart';
import 'package:flutter/material.dart';

import '../models/user/user_model.dart';

class SingUpProvider extends ChangeNotifier {
  bool isObscure = true;
  ApiProvider apiProvider = ApiProvider();

  late dynamic dataFuture;

  ResponseModel? registerStatus;
  var error;
  var response;

  changeIsObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  callRegisterApi(name, email, password) async {
    // start loading api
    registerStatus = ResponseModel.loading("is loading...");
    notifyListeners();

    try {
      // fetch data from api and goto mainWrapper
      response = await apiProvider.callRegisterApi(name, email, password);
      if (response.statusCode == 201) {
        dataFuture = UserModel.fromJson(response.data);
        registerStatus = ResponseModel.completed(dataFuture);

        // have validate error
      } else if (response.statusCode == 200) {
        dataFuture = ApiStatus.fromJson(response.data);
        registerStatus = ResponseModel.error(dataFuture.message);
      }
      notifyListeners();
    } catch (e) {
      // catch any error and show error
      registerStatus = ResponseModel.error("please check your connection...");
      notifyListeners();
      print(e.toString());
    }
  }
}
