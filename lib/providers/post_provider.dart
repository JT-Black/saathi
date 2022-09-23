import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  String _name = '';
  String _image = '';
  int _amount = 0;
  String _currency = '';
  int _duration = 0;
  String _durationType = '';
  String _state = '';

  String get name => _name;
  String get image => _image;
  int get amount => _amount;
  String get currency => _currency;
  int get duration => _duration;
  String get durationType => _durationType;
  String get state => _state;

  void updateName(String name) {
    _name = name;
    notifyListeners();
  }

  void updateImage(String image) {
    _image = image;
    notifyListeners();
  }

  void updateAmount(int amount) {
    _amount = amount;
    notifyListeners();
  }

  void updateCurrency(String currency) {
    _currency = currency;
    notifyListeners();
  }

  void updateDuration(int duration) {
    _duration = duration;
    notifyListeners();
  }

  void updateDurationType(String durationType) {
    _durationType = durationType;
    notifyListeners();
  }

  void updateState(String state) {
    _state = state;
    notifyListeners();
  }

  void reset() {
    _name = '';
    _image = '';
    _amount = 0;
    _currency = '';
    _duration = 0;
    _durationType = '';
    _state = '';
    notifyListeners();
  }
}
