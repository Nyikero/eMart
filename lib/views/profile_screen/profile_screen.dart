import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/chat_screen/messaging_screen.dart';
import 'package:e_mart/views/orders_screen/orders_screen.dart';
import 'package:e_mart/views/wishlist_screen/wishlist_screen.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarIconBrightness: Brightness.light,
    //   systemNavigationBarColor: lightGrey,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ));
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
      body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                  child: Column(
                children: [
                  // Edit profile button
                  12.heightBox,
                  const Align(
                          alignment: Alignment.topRight,
                          child: Icon(
                            Icons.edit,
                            color: whiteColor,
                          ))
                      .box
                      .padding(const EdgeInsets.only(right: 12, bottom: 12))
                      .make()
                      .onTap(() {
                    controller.nameController.text = data['name'];

                    Get.to(() => EditProfileScreen(data: data));
                  }),

                  // User's details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        data['imageUrl'] == ''
                            ? Image.asset(imgProfile2,
                                width: 70, height: 70, fit: BoxFit.cover)
                            : Image.network(data['imageUrl'],
                                    width: 70, height: 70, fit: BoxFit.cover)
                                .box
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make(),
                        10.widthBox,
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['name']}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .white
                                .make(),
                            "${data['email']}".text.white.make().box.make()
                          ],
                        )),

                        // Log out Button
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: whiteColor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: "Log out"
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make()),
                        )
                      ],
                    ),
                  ),

                  20.heightBox,
                  FutureBuilder(
                      future: FirestoreServices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: loadingIndicator());
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                  count: countData[0].toString(),
                                  title: "Item(s) in cart",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[1].toString(),
                                  title: "Item(s) in wishlist",
                                  width: context.screenWidth / 3.4),
                              detailsCard(
                                  count: countData[2].toString(),
                                  title: "Order(s)",
                                  width: context.screenWidth / 3.4)
                            ],
                          );
                        }
                      }),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(
                  //         count: data['cart_count'],
                  //         title: "Item(s) in cart",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['wishlist_count'],
                  //         title: "Item(s) in wishlist",
                  //         width: context.screenWidth / 3.4),
                  //     detailsCard(
                  //         count: data['order_count'],
                  //         title: "Order(s)",
                  //         width: context.screenWidth / 3.4)
                  //   ],
                  // ),

                  // Buttons section
                  ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () {
                                switch (index) {
                                  case 0:
                                    Get.to(() => const OrdersScreen());
                                    break;
                                  case 1:
                                    Get.to(() => const WishlistScreen());
                                    break;
                                  case 2:
                                    Get.to(() => const MessagesScreen());
                                    break;
                                }
                              },
                              leading: Image.asset(profileButtonsIcon[index],
                                  width: 22),
                              title: profileButtonsList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              color: lightGrey,
                            );
                          },
                          itemCount: profileButtonsList.length)
                      .box
                      .white
                      .rounded
                      .margin(const EdgeInsets.all(12))
                      .shadowSm
                      .make()
                      .box
                      .color(redColor)
                      .make()
                ],
              ));
            }
          }),
    ));
  }
}
