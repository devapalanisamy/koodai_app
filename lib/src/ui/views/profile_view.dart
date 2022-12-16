import 'package:ConsumerApp/src/core/models/user.dart';
import 'package:ConsumerApp/src/core/viewmodels/profile_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();
  final User user;

  const ProfileView({Key key, this.user}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _firstNameController = TextEditingController();

    final TextEditingController _lastNameController = TextEditingController();

    final TextEditingController _emailController = TextEditingController();

    final TextEditingController _mobileController = TextEditingController();

    return BaseView<ProfileViewModel>(
      setupViewModel: (viewmodel) async {
        await viewmodel.setUser();
        _firstNameController.text = viewmodel.user.firstName;
        _lastNameController.text = viewmodel.user.lastName;
        _emailController.text = viewmodel.user.email;
        _mobileController.text = viewmodel.user.phone;
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: viewModel.user != null
              ? SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: ProfileView._formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                      labelText: 'First name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'First name'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter valid full name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                      labelText: 'Last name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'Last name'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter valid address line1';
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
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'Email'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter valid address line2';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: _mobileController,
                                  decoration: InputDecoration(
                                      labelText: 'Telephone/Mobile',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: 'Telephone/Mobile'),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter valid city';
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
                                if (ProfileView._formKey.currentState
                                    .validate()) {
                                  if (viewModel.user == null)
                                    viewModel.user = User();
                                  viewModel.user.firstName =
                                      _firstNameController.text;
                                  viewModel.user.lastName =
                                      _lastNameController.text;
                                  viewModel.user.email = _emailController.text;
                                  viewModel.user.phone = _mobileController.text;

                                  await viewModel.updateUser();
                                }
                              },
                              child: Text(
                                'Update',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                ),
        );
      },
    );
  }
}
