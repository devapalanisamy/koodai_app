import 'package:ConsumerApp/src/core/models/address.dart';
import 'package:ConsumerApp/src/core/viewmodels/address_view_model.dart';
import 'package:ConsumerApp/src/ui/views/base_view.dart';
import 'package:flutter/material.dart';

class AddressView extends StatefulWidget {
  static final _formKey = GlobalKey<FormState>();
  final Address address;

  const AddressView({Key key, this.address}) : super(key: key);

  @override
  _AddressViewState createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _addressLine1Controller = TextEditingController();

  final TextEditingController _addressLine2Controller = TextEditingController();

  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _postCodeController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddressViewModel>(
      setupViewModel: (viewmodel) {
        if (widget.address != null) {
          _fullNameController.text = widget.address.fullName;
          _addressLine1Controller.text = widget.address.addressLine1;
          _addressLine2Controller.text = widget.address.addressLine2;
          _cityController.text = widget.address.city;
          _postCodeController.text = widget.address.postCode;
          _mobileController.text = widget.address.mobile;
          viewmodel.address = widget.address;
        }
      },
      builder: (context, viewModel, child) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Address'),
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
                    key: AddressView._formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                              labelText: 'Fullname',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Fullname'),
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
                          controller: _addressLine1Controller,
                          decoration: InputDecoration(
                              labelText: 'Address Line1',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Address Line1'),
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
                          controller: _addressLine2Controller,
                          decoration: InputDecoration(
                              labelText: 'Address Line2',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Address Line2'),
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
                          controller: _cityController,
                          decoration: InputDecoration(
                              labelText: 'City',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'City'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid city';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _postCodeController,
                          decoration: InputDecoration(
                              labelText: 'Post Code',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: 'Post Code'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid post code';
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
                              labelText: 'Mobile',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: 'Mobile'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter valid mobile number';
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
                        if (AddressView._formKey.currentState.validate()) {
                          if (viewModel.address == null)
                            viewModel.address = Address();
                          viewModel.address.fullName = _fullNameController.text;
                          viewModel.address.addressLine1 =
                              _addressLine1Controller.text;
                          viewModel.address.addressLine2 =
                              _addressLine2Controller.text;
                          viewModel.address.city = _cityController.text;
                          viewModel.address.postCode = _postCodeController.text;
                          viewModel.address.mobile = _mobileController.text;

                          await viewModel.edit();
                        }
                      },
                      child: Text(
                        viewModel.address == null ? 'Add' : 'Update',
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
