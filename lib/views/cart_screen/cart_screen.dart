import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/cart_controller.dart';
import 'package:e_mart/views/cart_screen/shipping_screen.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        // bottomNavigationBar: SizedBox(
        //     width: context.screenWidth - 60,
        //     height: 60,
        //     child: ElevatedButton(
        //         onPressed: () {
        //           Get.to(() => const ShippingDetails());
        //         },
        //         style: ElevatedButton.styleFrom(
        //             backgroundColor: Colors.blue[800],
        //             foregroundColor: whiteColor,
        //             shape: const RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.zero))),
        //         child: const Text("Proceed to shipping"))),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: whiteColor),
          backgroundColor: redColor,
          automaticallyImplyLeading: false,
          title: "Shopping cart"
              .text
              .color(whiteColor)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Image.network(
                                      "${data[index]['img']}",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    ),
                                    title:
                                        "${data[index]['title']} (x${data[index]['qty']})"
                                            .text
                                            .fontFamily(semibold)
                                            .size(16)
                                            .make(),
                                    subtitle: "${data[index]['tprice']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(semibold)
                                        .make(),
                                    trailing: const Icon(Icons.delete,
                                            color: redColor)
                                        .onTap(() {
                                      FirestoreServices.deleteDocument(
                                          data[index].id);
                                    }),
                                  );
                                })
                            .box
                            .padding(const EdgeInsets.only(bottom: 8))
                            .make()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Total price"
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .make(),
                        Obx(
                          () => "${controller.totalP.value}"
                              .numCurrency
                              .text
                              .fontFamily(semibold)
                              .color(redColor)
                              .make(),
                        )
                      ],
                    )
                        .box
                        .padding(const EdgeInsets.all(12))
                        .color(lightGolden)
                        .width(context.screenWidth - 60)
                        .roundedSM
                        .make(),
                    10.heightBox,
                    SizedBox(
                        width: context.screenWidth,
                        height: 60,
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const ShippingDetails());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: whiteColor,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.zero))),
                            child: const Text("Proceed to shipping")))
                  ],
                );
              }
            }));
  }
}
