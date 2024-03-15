import 'package:book_app/Model/otpModel.dart';

class OtpViewModel {
  final OtpModel _otpModel;

  OtpViewModel(this._otpModel);

  void setOtp1(String otp) {
    _otpModel.setOtp(otp);
  }
}
