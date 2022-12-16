import 'package:ConsumerApp/src/core/viewmodels/order_success_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class OrderSuccessView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<OrderSuccessViewModel>(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Order Success'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Text('Order is placed succesfully'),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          height: 80,
          color: Theme.of(context).primaryColor,
          child: Row(
            children: [
              Spacer(),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: () async {
                  await viewModel.returnToHome();
                },
                child: Text('Return to Home'),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
