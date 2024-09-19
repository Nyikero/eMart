import 'dart:io';
import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: whiteColor),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Profile photo
              // If data image url and controller path is empty
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(imgProfile2,
                          width: 200, height: 200, fit: BoxFit.cover)
                      .box
                      .roundedFull
                      .clip(Clip.antiAlias)
                      .make()
                      .box
                      .make()

                  // If data is not empty but controller path is empty
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 200, height: 200, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()

                      // If both are empty
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              // Change button
              10.heightBox,
              ElevatedButton(
                      onPressed: () {
                        controller.changeImage(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: redColor,
                          foregroundColor: whiteColor,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)))),
                      child: const Text("Change"))
                  .box
                  .height(50)
                  .make(),

              const Divider(),

              // Name | Password
              20.heightBox,
              customTextField(
                  textInputAction: TextInputAction.next,
                  label: const Text(name),
                  fillColor: Colors.transparent,
                  controller: controller.nameController,
                  isPass: false),

              10.heightBox,
              customTextField(
                  textInputAction: TextInputAction.next,
                  label: const Text(oldpass),
                  controller: controller.oldpassController,
                  fillColor: Colors.transparent,
                  isPass: true),

              10.heightBox,
              customTextField(
                  label: const Text(newpass),
                  controller: controller.newpassController,
                  fillColor: Colors.transparent,
                  isPass: true),

              // Save button
              20.heightBox,
              controller.isloading.value
                  ? loadingIndicator()
                  : SizedBox(
                      width: context.screenWidth,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            controller.isloading(true);

                            // If image is not selected
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImageLink = data['imageUrl'];
                            }

                            // If old password matches database
                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newpassword:
                                      controller.newpassController.text);
                              await controller.updateProfile(
                                imgUrl: controller.profileImageLink,
                                name: controller.nameController.text,
                                password: controller.newpassController.text,
                              );
                              VxToast.show(context, msg: "Updated");
                            } else {
                              VxToast.show(context, msg: "Wrong old password");
                              controller.isloading(false);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: redColor,
                              foregroundColor: whiteColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)))),
                          child: const Text("Save")),
                    ),
            ],
          )
              .box
              .white
              .shadowSm
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(left: 12, right: 12))
              .make(),
        ),
      ),
    ));
  }
}
