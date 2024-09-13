import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../routes/route_helper.dart';
import 'package:get/get.dart';
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
        backgroundColor: const Color(0xFFE27A22),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8.0),
              const ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("images/users.png"),
                ),
                title: Text(
                  "User Name",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
                subtitle: Text("Profile"),
              ),
              const Divider(height: 5),
              ListTile(
                onTap: () {
                  Get.toNamed(RouteHelper.getProfile());
                },
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    CupertinoIcons.person,
                    color: Colors.blue,
                    size: 35,
                  ),
                ),
                title: const Text(
                  "Profile",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const SizedBox(height: 20),
              ListTile(
                onTap: () {
                  Get.toNamed(RouteHelper.getAddress());
                },
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[100],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.deepPurple,
                    size: 35,
                  ),
                ),
                title: const Text(
                  "Addresses",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const Divider(height: 40),
              ListTile(
                onTap: () {},
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.logout_outlined,
                    color: Colors.redAccent,
                    size: 35,
                  ),
                ),
                title: const Text(
                  "Log Out",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
