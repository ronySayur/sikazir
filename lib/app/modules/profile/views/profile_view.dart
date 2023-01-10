import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/widgets.dart';
import '../../../routes/app_pages.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfileView'),
        centerTitle: true,
      ),
      //stream
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              Center(
                child: CircularProgressIndicator(),
              );
            }

            //cek data
            if (snapshot.hasData) {
              //data user
              Map<String, dynamic> user = snapshot.data!.data()!;
              String defaultImage =
                  "https://ui-avatars.com/api/?name=${user['name']}";
              return ListView(
                padding: EdgeInsets.all(wDimension.height10 / 10),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Container(
                          width: wDimension.width20 * 10,
                          height: wDimension.height20 * 10,
                          child: ClipOval(
                            child: Image.network(
                              user["profile"] != null
                                  ? user["profile"] != ""
                                      ? user["profile"]
                                      : defaultImage
                                  : defaultImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: wDimension.height20),
                  wSmallText(
                    text: "${user['name']}",
                    align: TextAlign.center,
                    size: wDimension.font20,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(height: wDimension.height10),
                  wSmallText(
                    text: "${user['email']}",
                    align: TextAlign.center,
                    size: wDimension.font16,
                  ),
                  SizedBox(height: wDimension.height20),

                  //update profile
                  ListTile(
                      onTap: () =>
                          Get.toNamed(Routes.UPDATE_PROFILE, arguments: user),
                      leading: wAppIcon(
                        icon: Icons.person,
                        iconColor: Colors.grey,
                      ),
                      title: wBigText(text: "Update Profile")),

                  //Update pass
                  ListTile(
                      onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
                      leading: wAppIcon(
                        icon: Icons.vpn_key,
                        iconColor: Colors.grey,
                      ),
                      title: wBigText(text: "Update Password")),

                  //Jika admin maka tampilkan add pegawai
                  if (user['role'] == "admin")
                    ListTile(
                        onTap: () => Get.toNamed(Routes.ADD_PEGAWAI),
                        leading: wAppIcon(
                          icon: Icons.person_add,
                          iconColor: Colors.grey,
                        ),
                        title: wBigText(text: "Add Pegawai")),

                  //Logout
                  ListTile(
                      onTap: () => controller.logout(),
                      leading: wAppIcon(
                        icon: Icons.logout,
                        iconColor: Colors.grey,
                      ),
                      title: wBigText(text: "Logout")),
                ],
              );
            } else {
              return Center(
                child: Text("Tidak dapat memuat data user"),
              );
            }
          }),
    );
  }
}
