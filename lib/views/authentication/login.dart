import 'package:flutter/material.dart';
import 'package:korobori/components/component.dart';
import 'package:korobori/controller/authcontroller.dart';
import 'package:korobori/views/temppage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController pengenalanController = TextEditingController(),
      passwordController = TextEditingController();
  bool isPasswordShown = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/logo_korobori.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                          color: KoroboriComponent().getPrimaryColor(),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              'Selamat Datang ke Scoutify+',
                              style: KoroboriComponent().getTextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Log Masuk',
                              style: KoroboriComponent().getTextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 30),
                            KoroboriComponent().buildInput(pengenalanController,
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: KoroboriComponent().getPrimaryColor(),
                                ),
                                keyboardType: TextInputType.number,
                                hintText: 'Nombor Kad Pengenalan'),
                            const SizedBox(
                              height: 20,
                            ),
                            KoroboriComponent().buildInput(passwordController,
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: KoroboriComponent().getPrimaryColor(),
                                ),
                                isObscure: !isPasswordShown,
                                suffixIconButton: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isPasswordShown = !isPasswordShown;
                                      });
                                    },
                                    icon: Icon(
                                      isPasswordShown
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color:
                                          KoroboriComponent().getPrimaryColor(),
                                    )),
                                hintText: 'Kata Laluan'),
                            const SizedBox(
                              height: 40,
                            ),
                            KoroboriComponent().buildOutlinedButton(
                                Text(
                                  'Log Masuk',
                                  style: KoroboriComponent()
                                      .getTextStyle(color: Colors.white),
                                ), () async {
                              try {
                                AuthResponse authResponse =
                                    await AuthController().logIn(
                                        pengenalanController.text,
                                        passwordController.text);

                                if (authResponse.user == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Something went wrong, please contact with our administrator.")));
                                } else if (authResponse.user != null) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const TempPage(),
                                      ),
                                      (_) => false);
                                }
                              } on AuthException catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.message)));
                              }
                            }),
                            const Spacer(),
                            Center(
                              child: Text(
                                'Dikuasakan oleh',
                                style: KoroboriComponent().getTextStyle(
                                    style: FontStyle.italic,
                                    color: Colors.white,
                                    fontSize: 14),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Image.asset(
                                  'assets/images/scoutify_logo.png'),
                            ),
                            const SizedBox(
                              height: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
