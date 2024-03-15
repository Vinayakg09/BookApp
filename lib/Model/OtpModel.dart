import 'package:flutter/material.dart';

class OtpModel extends ChangeNotifier {
  String _otp = " ";

  String get otp {
    return _otp;
  }

  void setOtp(String newOtp) {
    _otp = newOtp;
    notifyListeners();
  }
}
