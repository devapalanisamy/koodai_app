import 'package:ConsumerApp/src/core/viewmodels/forgot_password_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ForgotPasswordViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Container(
            child: Image(
              image: AssetImage(
                'assets/images/logo.png',
              ),
              fit: BoxFit.contain,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
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
                            return 'Please enter valid first name';
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
                      if (_formKey.currentState.validate()) {
                        await viewModel.forgotPassword(
                          _usernameController.text,
                        );
                      }
                    },
                    child: Text(
                      'Submit',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                          color: Theme.of(context).colorScheme.background,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
