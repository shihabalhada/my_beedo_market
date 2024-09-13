import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_beedo_market/controllers/address_controller.dart';
import 'package:my_beedo_market/data/api/api_client.dart';
import 'package:my_beedo_market/data/repository/address_repo.dart';
import 'package:my_beedo_market/models/address_model.dart';
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
        title: Text(
          'Addresses',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: const Color(0xFFE27A22),
      ),
      body: Obx(() {
        if (addressController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: addressController.addresses.length,
          itemBuilder: (context, index) {
            var address = addressController.addresses[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Color(0xADEAE5E5),
                  child: Icon(Icons.location_on),
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 2, color: Color(0xADE27A22)),
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                    '${address.firstname} ${address.lastname}\n${address.phone}'),
                subtitle: Text(
                    '${address.country}, ${address.city}, ${address.address}'),
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
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFE27A22),
        foregroundColor: Colors.white,
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
    final neighborhoodController =
        TextEditingController(text: address.neighborhood);

    return AlertDialog(
      title: Text(address.id == null ? 'Add Address' : 'Update Address'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: firstnameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: lastnameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value?.length != 9 || value == null) {
                      return 'Phone Number must be of 9 digits';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.my_location),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter country';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_city),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter city';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: addressControllerField,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_history_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: TextFormField(
                  controller: neighborhoodController,
                  decoration: const InputDecoration(
                    labelText: 'Neighborhood',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_history),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter neighborhood';
                    }
                    return null;
                  },
                ),
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
                updatedAddress.id = null;
                addressController.updateAddress(add_id, updatedAddress);
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
