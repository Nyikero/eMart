import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/chat_screen/chat_screen.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: redColor,
      statusBarIconBrightness: Brightness.light,
    ));
    var controller = Get.put(ProductController());
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        controller.resetValues();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: lightGrey,
          appBar: AppBar(
            backgroundColor: lightGrey,
            title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWishlist(data.id, context);
                      } else {
                        controller.addToWishlist(data.id, context);
                      }
                    },
                    icon: Icon(Icons.favorite_outlined,
                        color:
                            controller.isFav.value ? redColor : darkFontGrey)),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Swiper Section
                    VxSwiper.builder(
                        autoPlay: true,
                        viewportFraction: 1.0,
                        height: 340,
                        itemCount: data['p_imgs'].length,
                        itemBuilder: (context, index) {
                          return Image.network(data['p_imgs'][index],
                              width: double.infinity, fit: BoxFit.cover);
                        }),

                    12.heightBox,
                    // Title and Details Section
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: title!.text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                    ),

                    12.heightBox,
                    // Rating
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: VxRating(
                          isSelectable: false,
                          value: double.parse(data['p_rating']),
                          onRatingUpdate: (value) {},
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          size: 25,
                          maxRating: 5),
                    ),

                    12.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: "${data['p_price']}"
                          .numCurrency
                          .text
                          .color(redColor)
                          .fontFamily(bold)
                          .size(18)
                          .make(),
                    ),

                    12.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.fontFamily(semibold).make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.message_rounded, color: darkFontGrey),
                        ).onTap(() {
                          Get.to(() => const ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),

                    // Color Section
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color: ".text.make(),
                              ),
                              Row(
                                  children: List.generate(
                                      data['p_colors'].length,
                                      (index) => Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              VxBox()
                                                  .size(40, 40)
                                                  .roundedFull
                                                  .color(Color(data['p_colors']
                                                          [index])
                                                      .withOpacity(1.0))
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .make()
                                                  .onTap(() {
                                                controller
                                                    .changeColorIndex(index);
                                              }),
                                              Visibility(
                                                  visible: index ==
                                                      controller
                                                          .colorIndex.value,
                                                  child: const Icon(Icons.done,
                                                      color: Colors.white))
                                            ],
                                          )))
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          // Quantity Row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity: ".text.make(),
                              ),
                              Obx(
                                () => Row(children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity();
                                        controller.calculateTotalPrice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: const Icon(Icons.remove)),
                                  controller.quantity.value.text
                                      .size(16)
                                      .color(darkFontGrey)
                                      .fontFamily(bold)
                                      .make(),
                                  IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(
                                            int.parse(data['p_quantity']));
                                        controller.calculateTotalPrice(
                                            int.parse(data['p_price']));
                                      },
                                      icon: const Icon(Icons.add)),
                                  10.widthBox,
                                  "(${data['p_quantity']} available)"
                                      .text
                                      .make()
                                ]),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          // Total Row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Total: ".text.make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.make(),
                    ),

                    // Description Section
                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: "Description"
                          .text
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .make(),
                    ),

                    10.heightBox,
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child:
                          "${data['p_desc']}".text.color(darkFontGrey).make(),
                    ),

                    // Buttons Section
                    10.heightBox,
                    ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            itemDetailsButtonsList.length,
                            (index) => ListTile(
                                  title: itemDetailsButtonsList[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  trailing: const Icon(Icons.arrow_forward),
                                ))),

                    20.heightBox,
                    // Products you may also like section
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 12),
                    //   child: productsYouMayLike.text
                    //       .fontFamily(bold)
                    //       .size(16)
                    //       .color(darkFontGrey)
                    //       .make(),
                    // ),

                    // SingleChildScrollView(
                    //   padding:
                    //       const EdgeInsets.only(left: 12, bottom: 12, top: 12),
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //       children: List.generate(
                    //           6,
                    //           (index) => Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(left: 20),
                    //                     child: Image.asset(imgP1,
                    //                         width: 150, fit: BoxFit.cover),
                    //                   ),
                    //                   12.heightBox,
                    //                   "Hewlett Packard (HP) Laptop"
                    //                       .text
                    //                       .fontFamily(semibold)
                    //                       .color(darkFontGrey)
                    //                       .make(),
                    //                   "\$600"
                    //                       .text
                    //                       .color(redColor)
                    //                       .fontFamily(bold)
                    //                       .size(16)
                    //                       .make()
                    //                 ],
                    //               )
                    //                   .box
                    //                   .white
                    //                   .roundedSM
                    //                   .shadowSm
                    //                   .margin(const EdgeInsets.only(right: 12))
                    //                   .padding(const EdgeInsets.all(12))
                    //                   .make())),
                    // )
                  ],
                  // Details UI is completed...
                ),
              )),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                    onPressed: () {
                      if (controller.quantity.value > 0) {
                        controller.addToCart(
                            color: data['p_colors']
                                [controller.colorIndex.value],
                            context: context,
                            vendorID: data['vendor_id'],
                            img: data['p_imgs'][0],
                            qty: controller.quantity.value,
                            sellername: data['p_seller'],
                            title: data['p_name'],
                            tprice: controller.totalPrice.value);
                        VxToast.show(context, msg: "Added to cart");
                      } else {
                        VxToast.show(context,
                            msg: "Minimum 1 product is required");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero)),
                        backgroundColor: Colors.blue,
                        foregroundColor: whiteColor),
                    child: const Text("Add to cart")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
