import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furniture_app/blocs/authentication/auth.dart';
import 'package:furniture_app/blocs/login/login.dart';
import './background_paint.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginBloc loginBloc;
  AuthBloc authBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    loginBloc = LoginBloc(authBloc);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(223, 211, 195, 1),
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: true,
      body: Stack(children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          child: Image(image: new AssetImage("images/VAtas.png"),
          fit: BoxFit.cover,)
        ),
        Center(
          child: Container(
            padding: EdgeInsets.all(32.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 25.0,
                  ),
                  Text('Login',
                      style: TextStyle(
                          fontSize: 42.0,
                          fontFamily: 'Roboto',
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 2),
                            Shadow(color: Colors.black87, blurRadius: 3)
                          ],
                          color: Color.fromRGBO(131, 132, 105, 1),
                          fontWeight: FontWeight.bold)),
                  Text('Harpa Furniture',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Roboto',
                        shadows: [
                          Shadow(color: Colors.black, blurRadius: 2),
                          Shadow(color: Colors.black87, blurRadius: 3)
                        ],
                        color: Color.fromRGBO(131, 132, 105, 1),
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  FormLogin(
                    scaffoldKey: _scaffoldKey,
                    loginBloc: loginBloc,
                  ),
                ],
              )),
            ),
          ),
        ),
      Positioned(
          bottom: 0,
          right: 0,
          child: Image(image: new AssetImage("images/VBawah.png"),
          fit: BoxFit.cover,)
        ),
      ]),
    );
  }
}

class FormLogin extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final LoginBloc loginBloc;

  FormLogin({Key key, this.scaffoldKey, this.loginBloc}) : super(key: key);

  var _formKey = GlobalKey<FormState>();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Username',
              ),
              validator: ((val) {
                if (val.isEmpty) return 'Masukan Username anda';
              }),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            shadowColor: Colors.black54,
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                fillColor: Color.fromRGBO(233, 233, 233, 1),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                contentPadding: EdgeInsets.all(15.0),
                labelText: 'Password',
              ),
              validator: (val) {
                if (val.isEmpty) return 'Masukan Password anda';
              },
            ),
          ),
          SizedBox(
            height: 25,
          ),
          btnSubmit()
        ],
      ),
    ));
  }

  Widget btnSubmit() {
    return BlocBuilder(
      bloc: loginBloc,
      builder: (BuildContext context, LoginState state) {
        if (state is LoadingLogin) {
          return Center(child: CircularProgressIndicator());
        } else {
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
              width: 70,
              height: 50,
              child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(131, 132, 105, 1),
                      shape: BoxShape.circle),
                  child: Icon(
                    MdiIcons.arrowRight,
                    color: Colors.white,
                  )),
            ),
          );
          // return FlatButton.icon(
          //   icon: Icon(MdiIcons.arrowRight),
          //   label: Text(''),
          //   color: Color.fromRGBO(131, 132, 105, 1),
          //   textColor: Colors.white,
          //   onPressed: _onLogin,
          // );
        }
      },
    );
  }

  void _onLogin() {
    if (_formKey.currentState.validate()) {
      _usernameController.text = 'zeinersyad';
      _passwordController.text = '123456';
      loginBloc.dispatch(SubmitLogin(
          _usernameController.text, _passwordController.text, scaffoldKey));
    }
  }
}