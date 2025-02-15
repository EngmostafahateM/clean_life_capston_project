import 'package:flutter/cupertino.dart';

import '../models/signuploginmodel.dart';
import '../services/Loginservices.dart';


class loginprovider extends ChangeNotifier
{
  signuploginmodel? data;
  Future<void>login( email, password)async
  {

      data= await Loginservices. addData(email,password);

         notifyListeners();

  }

}