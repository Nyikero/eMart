import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/cart_controller.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
    ));
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ElevatedButton(
                  onPressed: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "Order placed Successfully");
                    Get.offAll(() => const Home());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: whiteColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.zero))),
                  child: const Text("Place my order")),
        ),
        appBar: AppBar(
            backgroundColor: whiteColor,
            title: "Choose Payment Method"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make()),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 4)),
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(paymentMethodsImg[index],
                            width: double.infinity,
                            height: 120,
                            colorBlendMode:
                                controller.paymentIndex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.5)
                                : Colors.transparent,
                            fit: BoxFit.cover),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          child: paymentMethods[index]
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
