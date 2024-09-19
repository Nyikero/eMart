import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  //var controller = Get.put(AuthController());

  // Text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) =>
          Get.to(() => const LoginScreen()),
      child: bgWidget(
          child: Scaffold(
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              appLogoWidget(),
              10.heightBox,
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Name, Email, Password & Retype Password Text Fields

                        customTextField(
                            textInputAction: TextInputAction.next,
                            label: const Text(name),
                            isPass: false,
                            fillColor: Colors.transparent,
                            controller: nameController),
                        5.heightBox,
                        customTextField(
                            textInputAction: TextInputAction.next,
                            label: const Text(email),
                            isPass: false,
                            fillColor: Colors.transparent,
                            controller: emailController),
                        5.heightBox,
                        customTextField(
                            textInputAction: TextInputAction.next,
                            label: const Text(password),
                            isPass: true,
                            fillColor: Colors.transparent,
                            controller: passwordController),
                        5.heightBox,
                        customTextField(
                            label: const Text(retypePassword),
                            isPass: true,
                            fillColor: Colors.transparent,
                            controller: passwordRetypeController),

                        // Checkbox
                        Row(
                          children: [
                            Checkbox(
                                activeColor: redColor,
                                checkColor: whiteColor,
                                value: isCheck,
                                onChanged: (newValue) {
                                  setState(() {
                                    isCheck = newValue;
                                  });
                                }),
                            10.widthBox,

                            // I agree to the Terms and Conditions and Privacy Policy
                            Expanded(
                              child: RichText(
                                  text: const TextSpan(children: [
                                TextSpan(
                                    text: "I agree to the ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: termAndCond,
                                    style: TextStyle(
                                        fontFamily: regular, color: redColor)),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                        fontFamily: regular, color: redColor))
                              ])),
                            )
                          ],
                        ),
                        5.heightBox,

                        // Sign up Button
                        controller.isloading.value
                            ? loadingIndicator()
                            : ElevatedButton(
                                    onPressed: () async {
                                      if (isCheck != false &&
                                          nameController.text.isNotEmpty &&
                                          emailController.text.isNotEmpty &&
                                          passwordController.text.isNotEmpty &&
                                          passwordRetypeController
                                              .text.isNotEmpty) {
                                        controller.isloading(true);
                                        try {
                                          await controller
                                              .signupMethod(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then((value) {
                                            return controller.storeUserData(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                name: nameController.text);
                                          }).then((value) {
                                            VxToast.show(context,
                                                msg: loggedIn);
                                            Get.offAll(() => const Home());
                                          });
                                        } catch (e) {
                                          auth.signOut();
                                          VxToast.show(context,
                                              msg: e.toString());
                                          controller.isloading(false);
                                        }
                                      } else {
                                        VxToast.show(context,
                                            msg: "Please fill out the fields");
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: isCheck == true
                                            ? redColor
                                            : lightGrey,
                                        foregroundColor: whiteColor),
                                    child: const Text('Sign up'))
                                .box
                                .width(context.screenWidth)
                                .make(),
                        10.heightBox,

                        // Wrapping into gesture detector of velosity x
                        // Already have an account? Log in
                        RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: alreadyHaveAccount,
                              style:
                                  TextStyle(fontFamily: bold, color: fontGrey)),
                          TextSpan(
                              text: login,
                              style:
                                  TextStyle(fontFamily: bold, color: redColor))
                        ])).onTap(() {
                          Get.to(() => const LoginScreen());
                        })
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
