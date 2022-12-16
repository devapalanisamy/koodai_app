import 'package:ConsumerApp/src/core/viewmodels/register_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
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
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: RegisterView._formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _firstnameController,
                          decoration: InputDecoration(
                              labelText: 'Firstname',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Firstname'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid first name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _lastnameController,
                          decoration: InputDecoration(
                              labelText: 'Lastname',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Lastname'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid last name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Email'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                              labelText: 'Phone',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Phone'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid phone number';
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
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid password';
                            }
                            if (value != _passwordController.text) {
                              return 'Password does not match';
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
                        if (RegisterView._formKey.currentState.validate()) {
                          await viewModel.register(
                              _firstnameController.text,
                              _lastnameController.text,
                              _emailController.text,
                              _phoneController.text,
                              _passwordController.text);
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
      ),
    );
  }
}
