import 'package:ConsumerApp/src/core/models/user.dart';
import 'package:ConsumerApp/src/core/viewmodels/change_password_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class ChangePasswordView extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();
  final User user;

  const ChangePasswordView({Key key, this.user}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _oldPasswordController =
        TextEditingController();

    final TextEditingController _newPasswordController =
        TextEditingController();

    final TextEditingController _confirmNewPasswordContoller =
        TextEditingController();

    return BaseView<ChangePasswordViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
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
                      key: ChangePasswordView._formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _oldPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Old Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Old Password'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter valid old password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _newPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'New Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'New Password'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter valid password';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _confirmNewPasswordContoller,
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Confirm New Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: 'Confirm New Password'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter valid address line2';
                              }
                              if (_newPasswordController.text != value) {
                                return 'Passwords do not macth';
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
                          if (ChangePasswordView._formKey.currentState
                              .validate()) {
                            await viewModel.changePassword(
                                _oldPasswordController.text,
                                _newPasswordController.text);
                          }
                        },
                        child: Text(
                          'Update',
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
      },
    );
  }
}
