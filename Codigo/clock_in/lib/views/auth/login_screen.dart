import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/stores/auth_store.dart';
import 'package:clock_in/stores/login_store.dart';
import 'package:clock_in/views/auth/sign_up_page.dart';
import 'package:clock_in/views/base_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String routeName = "/LoginPage";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthStore authStore = GetIt.I<AuthStore>();
  final LoginStore loginStore = LoginStore();

  final List<ReactionDisposer> _disposers = [];

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _disposers.add(
      autorun(
        (_) {
          if (loginStore.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                loginStore.error!,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 4),
            ));
          }
        },
      ),
    );
    _disposers.add(
      autorun(
        (_) {
          if (authStore.isLoggedIn) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const BaseScreen(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Color(0xffF5591F),
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/logo.png",
                        // height: 150,
                        // width: 90,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      onChanged: loginStore.setEmail,
                      enabled: !loginStore.loading,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.mail_outline_outlined,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                        hintText: 'E-mail',
                        contentPadding: EdgeInsets.fromLTRB(5, 20, 20, 20),
                        hintStyle: TextStyle(
                          color: Colors.blueGrey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    );
                  }),
                  Observer(builder: (_) {
                    return TextField(
                      onChanged: loginStore.setPassword,
                      enabled: !loginStore.loading,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      obscureText: !loginStore.showPassword,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock_outline,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                        suffix: IconButton(
                          icon: loginStore.showPassword
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.blueGrey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.blueGrey,
                                ),
                          onPressed: loginStore.showHidePassword,
                        ),
                        hintText: 'Senha',
                        contentPadding:
                            const EdgeInsets.fromLTRB(5, 20, 20, 20),
                        hintStyle: const TextStyle(
                          color: Colors.blueGrey,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 40,
                    child: Observer(builder: (context) {
                      return ElevatedButton(
                        onPressed: loginStore.loginPressed,
                        child: loginStore.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'ENTRAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        style: ButtonStyle(
                          backgroundColor:
                              loginStore.formValid && !loginStore.loading
                                  ? MaterialStateProperty.all(
                                      Colors.blueGrey[600],
                                    )
                                  : MaterialStateProperty.all(
                                      Colors.blueGrey.withAlpha(120),
                                    ),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                      );
                    }),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        const Text(
                          'N??o tem uma conta? ',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const SignUpPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Cadastre-se',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w700,
                              color: Colors.blueGrey,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
