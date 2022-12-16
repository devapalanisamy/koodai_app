import 'package:ConsumerApp/src/core/viewmodels/login_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: [
                Container(
                  width: 150,
                  child: Image(
                    image: AssetImage(
                      'assets/images/logo.png',
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: LoginView._formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Username'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter valid password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 48,
                  width: 180,
                  child: RaisedButton(
                    onPressed: () async {
                      if (LoginView._formKey.currentState.validate()) {
                        await viewModel.login(
                            _usernameController.text, _passwordController.text);
                      }
                    },
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () async {
                    await viewModel.forgotPassword();
                  },
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FlatButton(
                  onPressed: () async {
                    await viewModel.showProducts();
                  },
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New user?',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    FlatButton(
                        onPressed: () async {
                          await viewModel.register();
                        },
                        child: Text(
                          'Register',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(decoration: TextDecoration.underline),
                        )),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
