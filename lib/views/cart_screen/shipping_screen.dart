import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/controllers/cart_controller.dart';
import 'package:e_mart/views/cart_screen/payment_method.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ElevatedButton(
            onPressed: () {
              if (controller.addressController.text.isNotEmpty &&
                  controller.cityController.text.isNotEmpty &&
                  controller.stateController.text.isNotEmpty &&
                  controller.postalcodeController.text.isNotEmpty &&
                  controller.phoneController.text.isNotEmpty) {
                Get.to(() => const PaymentMethods());
              } else {
                VxToast.show(context, msg: "Please fill the form");
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: whiteColor,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero))),
            child: const Text("Continue")),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              customTextField(
                  textInputAction: TextInputAction.next,
                  label: const Text("Address"),
                  isPass: false,
                  fillColor: Colors.transparent,
                  controller: controller.addressController),
              customTextField(
                  textInputAction: TextInputAction.next,
                  label: const Text("City"),
                  isPass: false,
                  fillColor: Colors.transparent,
                  controller: controller.cityController),
              customTextField(
                  textInputAction: TextInputAction.next,
                  label: const Text("State"),
                  isPass: false,
                  fillColor: Colors.transparent,
                  controller: controller.stateController),
              customTextField(
                  textInputAction: TextInputAction.next,
                  label: const Text("Postal Code"),
                  isPass: false,
                  fillColor: Colors.transparent,
                  controller: controller.postalcodeController),
              customTextField(
                  label: const Text("Phone Number"),
                  isPass: false,
                  fillColor: Colors.transparent,
                  controller: controller.phoneController)
            ],
          ),
        ),
      ),
    );
  }
}
