import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/stores/signup_store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static const String routeName = "/SignUpPage";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignupStore signupStore = SignupStore();

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
          if (signupStore.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                signupStore.error!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.redAccent,
              duration: const Duration(seconds: 4),
            ));
          }
        },
      ),
    );
    _disposers.add(
      reaction(
        (_) => !signupStore.loading && signupStore.userCreated,
        (_) => Navigator.of(context).popUntil((route) => route.isFirst),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Icon(
                    Icons.access_time_sharp,
                    color: Colors.grey,
                    size: 160,
                  ),
                  Observer(builder: (_) {
                    return TextField(
                      onChanged: signupStore.setName,
                      enabled: !signupStore.loading,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person_outline,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                        hintText: 'Nome',
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
                      onChanged: signupStore.setEmail,
                      enabled: !signupStore.loading,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.mail_outline,
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
                      onChanged: signupStore.setPassword1,
                      enabled: !signupStore.loading,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      obscureText: !signupStore.showPassword1,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock_outline,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                        suffix: IconButton(
                          icon: signupStore.showPassword1
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.blueGrey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.blueGrey,
                                ),
                          onPressed: signupStore.showHidePassword1,
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
                  Observer(builder: (_) {
                    return TextField(
                      onChanged: signupStore.setPassword2,
                      enabled: !signupStore.loading,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                      obscureText: !signupStore.showPassword2,
                      decoration: InputDecoration(
                        icon: const Icon(
                          Icons.lock_outline,
                          color: Colors.blueGrey,
                          size: 30,
                        ),
                        suffix: IconButton(
                          icon: signupStore.showPassword2
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.blueGrey,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.blueGrey,
                                ),
                          onPressed: signupStore.showHidePassword2,
                        ),
                        hintText: 'Repita sua senha',
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
                    height: 32,
                  ),
                  SizedBox(
                    height: 40,
                    child: Observer(builder: (context) {
                      return ElevatedButton(
                        onPressed: signupStore.signupPressed,
                        child: signupStore.loading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'CADASTRAR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        style: ButtonStyle(
                          backgroundColor:
                              signupStore.isFormValid && !signupStore.loading
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
