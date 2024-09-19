import 'package:e_mart/consts/consts.dart';

Widget featuredButton({String? title, icon}) {
  // ignore: unused_local_variable
  var controller = Get.put(ProductController());
  return Row(
    children: [
      Image.asset(
        icon,
        width: 40,
        fit: BoxFit.cover,
      ),
      12.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .margin(const EdgeInsets.only(right: 12))
      .padding(const EdgeInsets.only(left: 12, bottom: 12, top: 12))
      .width(200)
      .white
      .roundedSM
      .shadowSm
      .make()
      .onTap(() {
    Get.to(() => CategoryDetails(title: title));
  });
}
