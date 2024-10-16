import 'package:book_app/View/Utils/appbar.dart';
import 'package:book_app/View/Utils/toast.dart';
import 'package:book_app/View/confirmPage/page/confirmPage.dart';
import 'package:book_app/View/loginPage/bloc/auth_bloc.dart' as auth;
import 'package:book_app/View/loginPage/page/loginPage.dart';
import 'package:book_app/View/welcome_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../Utils/navigate_status.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late TextEditingController otpController;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  String userId = "";
  @override
  Widget build(BuildContext context) {
    debugPrint('OtpPage rebuilt');
    return Scaffold(
      appBar: appBar(nextPage: LoginPage()),
      body: BlocConsumer<auth.AuthBloc, auth.AuthState>(
        listener: (context, state) {
          if (state is auth.AuthFailure) {
            toast().toastMessage(state.error, Colors.red);
          }
        },
        builder: (context, state) {
          if (state is auth.AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavigateStatus(a: 147, b: 177, c: 166, o: 1),
                    NavigateStatus(a: 0, b: 137, c: 101, o: 1),
                    NavigateStatus(a: 147, b: 177, c: 166, o: 1),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              const Text(
                "Enter the OTP code sent to your Email",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              Flexible(
                child: Text(
                  widget.email,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.robotoSerif(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: PinCodeTextField(
                  appContext: context,
                  controller: otpController,
                  length: 6,
                  textStyle: const TextStyle(color: Colors.white),
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  pinTheme: PinTheme(
                    fieldWidth: 45,
                    fieldHeight: 45,
                    shape: PinCodeFieldShape.box,
                    selectedColor: const Color.fromRGBO(217, 217, 217, 0.74),
                    inactiveColor: const Color.fromRGBO(217, 217, 217, 0.74),
                    activeColor: const Color.fromRGBO(0, 137, 101, 1),
                  ),
                  onChanged: (value) {
                    //only for debug
                    debugPrint(value);
                  },
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 200,
                height: 45,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final response = await supabase.auth.verifyOTP(
                          email: widget.email,
                          token: otpController.text,
                          type: OtpType.email);

                      if (response.session?.accessToken != null) {
                        final userId = supabase.auth.currentUser!.id;
                        final userPresent = await supabase
                            .from('userid_table')
                            .select()
                            .eq('user_id', userId);
                        if (userPresent.isNotEmpty &&
                            userPresent[0]['user_id'] != null &&
                            userPresent[0]['email'] != null) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("userEmail", widget.email);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => const Welcome()),
                              (route) => false);
                        } else {
                          await supabase.from('userid_table').insert({
                            'user_id': userId,
                            'email': widget.email,
                          });
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString("userEmail", widget.email);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const ConfirmPage()),
                              (route) => false);
                        }
                      } else {
                        toast().toastMessage("Unsuccesfull", Colors.red);
                      }
                    } catch (e) {
                      toast().toastMessage("Error $e", Colors.red);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(0, 137, 101, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  child: const Text(
                    'Verify',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 60.0, right: 60.0),
                child: Divider(
                  color: Color.fromRGBO(65, 62, 62, 1),
                  thickness: 5,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Didn’t received the verification OTP?",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: Colors.white),
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      debugPrint(widget.email);
                      await supabase.auth.signInWithOtp(
                        email: widget.email,
                      );
                    } catch (e) {
                      toast().toastMessage(e.toString(), Colors.red);
                    }
                  },
                  child: const Text(
                    "Resend OTP",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(135, 184, 163, 1),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(135, 184, 163, 1)),
                  )),
              const SizedBox(
                height: 100,
              ),
              const Text(
                "By verifying, I hereby accept the",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(135, 184, 163, 1),
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromRGBO(135, 184, 163, 1)),
                  )),
            ],
          );
        },
      ),
    );
  }
}
