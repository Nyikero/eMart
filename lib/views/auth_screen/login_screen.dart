import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => SystemNavigator.pop(),
      child: bgWidget(
          child: Scaffold(
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        customTextField(
                            textInputAction: TextInputAction.next,
                            label: const Text(name),
                            isPass: false,
                            fillColor: Colors.transparent,
                            controller: controller.emailController),
                        5.heightBox,
                        customTextField(
                            label: const Text(password),
                            isPass: true,
                            fillColor: Colors.transparent,
                            controller: controller.passwordController),

                        // Forget Password
                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () {},
                                child: forgetPass.text.make())),

                        // Log in Button
                        5.heightBox,
                        controller.isloading.value
                            ? loadingIndicator()
                            : ourButton(
                                title: login,
                                onPress: () async {
                                  controller.isloading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: loggedIn);
                                      Get.offAll(() => const Home());
                                    } else {
                                      controller.isloading(false);
                                    }
                                  });
                                }).box.width(context.screenWidth - 50).make(),

                        // or, create a new account
                        5.heightBox,
                        createNewAccount.text.color(fontGrey).make(),

                        // Sign up Button
                        5.heightBox,
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const SignupScreen());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: lightGolden,
                              foregroundColor: redColor),
                          child: const Text('Sign up'),
                        ).box.width(context.screenWidth - 50).make(),

                        // Log in with
                        10.heightBox,
                        loginWith.text.color(fontGrey).make(),

                        // Facebook, Google, X
                        5.heightBox,
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                                3,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: lightGrey,
                                        radius: 25,
                                        child: Image.asset(
                                            socialIconList[index],
                                            width: 30),
                                      ),
                                    )))
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
