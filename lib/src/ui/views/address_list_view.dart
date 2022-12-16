import 'package:ConsumerApp/src/core/viewmodels/address_list_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class AddressListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<AddressListViewModel>(
      setupViewModel: (viewmodel) async => await viewmodel.setListOfAddresses(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Addresses'),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await viewModel.addAddress();
                }),
          ],
        ),
        body: SafeArea(
          child: viewModel.addresses != null && viewModel.addresses.length > 0
              ? ListView.builder(
                  itemCount: viewModel.addresses.length,
                  itemBuilder: (context, index) {
                    final address = viewModel.addresses[index];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.fullName,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(address.addressLine1),
                            Text(address.addressLine2),
                            Text(address.city),
                            Text(address.postCode),
                            Text(address.mobile),
                            Row(
                              children: [
                                RaisedButton(
                                  onPressed: () async {
                                    await viewModel.editAddress(address);
                                  },
                                  child: Text('Update'),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                RaisedButton(
                                  onPressed: () async {
                                    await viewModel.deleteAddress(address);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text('No address found'),
                ),
        ),
      ),
    );
  }
}
