import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppesta_store/bloc/authentication/authentication_bloc.dart';
import 'package:shoppesta_store/bloc/authentication/bloc.dart';
import 'package:shoppesta_store/bloc/login/login_bloc.dart';
import 'package:shoppesta_store/constants.dart';
import 'package:shoppesta_store/repositories/storeRepository.dart';
import 'package:shoppesta_store/ui/pages/signup.dart';

class LoginForm extends StatefulWidget {
  final StoreRepository _storeRepository;
  LoginForm({@required StoreRepository storeRepository})
      : assert(storeRepository != null),
        _storeRepository = storeRepository;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginBloc _loginBloc;

  StoreRepository get _storeRepository => widget._storeRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
          email: _emailController.text, password: _passwordController.text),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure)
          return Text('failed');
        else if (state.isSubmitting)
          return CircularProgressIndicator();
        else if (state.isSuccess)
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(

              width: size.width,
              height: size.height,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Shoppesta Store",
                      style: TextStyle(
                          fontSize: 30, color: Colors.red),
                    ),
                  ),
                  Container(
                    width: size.width * 0.8,
                    child: Divider(
                      height: size.height * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                            color: Colors.red, fontSize: size.height * 0.02),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(
                            color: Colors.red, fontSize: size.height * 0.02),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(size.height * 0.02),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()=>_onFormSubmitted(),
                          child: Container(
                            width: size.width * 0.8,
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              color:  Colors.red,
                              borderRadius:
                              BorderRadius.circular(size.height * 0.05),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: size.height * 0.025,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        GestureDetector(
                          onTap: () {

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return SignUp(
                                    storeRepository: _storeRepository,
                                  );
                                },
                              ),
                            );
                          },
                          child: Text(
                            "Are you new? Get an Account",
                            style: TextStyle(
                                fontSize: size.height * 0.023,
                                color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }
}
