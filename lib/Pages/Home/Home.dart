import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '/Pages/Home/scatter.dart';

import '../../Compo/user_controller.dart';
import '../../Profile/EditProfile.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key, this.isNetworkImage = false}) : super(key: key);
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 230,
              child: Column(
                children: [
                  AppBar(
                    title: Text(
                      'AROGYA',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditProfile()),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xFFA4BFA7),
                          // Background color red
                          // gradient: LinearGradient(
                          //   begin: Alignment.topLeft,
                          //   end: Alignment(1, 0.4),
                          //   colors: <Color>[
                          //     Color(0xffffb56b),
                          //     Color(0xfff39060),
                          //     Color(0xfff39060),
                          //     Color(0xffe16b5c),
                          //     Color(0xffe16b5c),
                          //     Color(0xffe16b5c),
                          //     Color(0xfff39060),
                          //     Color(0xffffb56b),
                          //   ], // Gradient from https://learnui.design/tools/gradient-generator.html
                          //   tileMode: TileMode.mirror,
                          // ),
                          borderRadius: BorderRadius.circular(20), // Border radius
                        ),
                        child: Row(
                          children: [
                            Obx(() {
                              final networkImage = controller.user.value.profilePicture;
                              final image = networkImage.isNotEmpty
                                  ? networkImage
                                  : 'assets/images/profile.png';
                              return Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Center(
                                    child: networkImage.isNotEmpty
                                        ? CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: image,
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                    )
                                        : Image(
                                      fit: BoxFit.cover,
                                      image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
                                      height: 120,
                                      width: 120,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => Text(
                                  controller.user.value.fullName,
                                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                                )),
                                Obx(() => Text(
                                  controller.user.value.email,
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16)
                ],
              ),
            ),

            SizedBox(height: 12,),
            ScatterChartSample1()
          ],

        ),
      ),
    );
  }
}
