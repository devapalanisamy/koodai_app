import 'package:ConsumerApp/src/core/viewmodels/more_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseView<MoreViewModel>(
      setupViewModel: (viewmodel) async => viewmodel.setLoginStatus(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            color: Colors.lightGreen,
            child: viewModel.isLoggedIn
                ? ListView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GestureDetector(
                        onTap: () async => await viewModel.showProfile(),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.person),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Profile',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.shopping_bag),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'My Orders',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async => await viewModel.changePassword(),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.vpn_key),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Change password',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async => await viewModel.showAddress(),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.house),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'My Addresses',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await viewModel.logout();
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Logout',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_ios),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text('Please login to see your account details here'),
                        RaisedButton(
                            child: Text('Login'),
                            onPressed: () async {
                              await viewModel.logout();
                            })
                      ],
                    ),
                  )),
      ),
    );
  }
}
