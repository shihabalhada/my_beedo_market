import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/controllers/address_controller.dart';
import 'package:my_beedo_market/models/address_model.dart';
import 'package:my_beedo_market/data/repository/address_repo.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/utils/app_constants.dart';

class AddressPage extends StatelessWidget {
  final AddressController addressController = Get.put(AddressController(
    addressRepo: AddressRepo(
      apiClient: ApiClient(appBaseUrl: AppConstants.BASE_URL),
    ),
  ));

  @override
  Widget build(BuildContext context) {
    String token = GetStorage().read('token') ?? '';

    addressController.getAddresses(token);

    return Scaffold(
      appBar: AppBar(
        title: Text('Addresses'),
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: addressController.addresses.length,
          itemBuilder: (context, index) {
            var address = addressController.addresses[index];
            return ListTile(
              title: Text('${address.phone} ${address.address}'),
              subtitle: Text('${address.city}, ${address.country}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Show update address form
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AddressForm(
                            addressController: addressController,
                            address: address,
                          );
                        },
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      addressController.deleteAddress(address.id!, token);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AddressForm(
                addressController: addressController,
                address: Address(
                  token: token,
                  firstname: '',
                  lastname: '',
                  phone: '',
                  country: '',
                  city: '',
                  address: '',
                  neighborhood: '',
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddressForm extends StatelessWidget {
  final AddressController addressController;
  final Address address;

  AddressForm({required this.addressController, required this.address});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String token = GetStorage().read('token');
    final firstnameController = TextEditingController(text: address.firstname);
    final lastnameController = TextEditingController(text: address.lastname);
    final phoneController = TextEditingController(text: address.phone);
    final countryController = TextEditingController(text: address.country);
    final cityController = TextEditingController(text: address.city);
    final addressControllerField = TextEditingController(text: address.address);
    final neighborhoodController = TextEditingController(text: address.neighborhood);

    return AlertDialog(
      title: Text(address.id == null ? 'Add Address' : 'Update Address'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: firstnameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastnameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: countryController,
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter country';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: cityController,
                decoration: InputDecoration(labelText: 'City'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter city';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: addressControllerField,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: neighborhoodController,
                decoration: InputDecoration(labelText: 'Neighborhood'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter neighborhood';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final updatedAddress = Address(
                id: address.id,
                token: token,
                firstname: firstnameController.text,
                lastname: lastnameController.text,
                phone: phoneController.text,
                country: countryController.text,
                city: cityController.text,
                address: addressControllerField.text,
                neighborhood: neighborhoodController.text,
              );

              if (address.id == null) {
                addressController.addAddress(updatedAddress);
              } else {
                int add_id = updatedAddress.id!;
                updatedAddress.id=null;
                addressController.updateAddress(add_id,updatedAddress);
              }

              Get.back();
            }
          },
          child: Text(address.id == null ? 'Add' : 'Update'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
