import 'package:flutter/foundation.dart';


class loadingProvider with ChangeNotifier{
  bool _load=false;

  bool get load=>_load;

  void loading(){
    _load=!_load;
    notifyListeners();
  }

}