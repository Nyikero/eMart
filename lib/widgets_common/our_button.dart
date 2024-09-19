import 'package:e_mart/consts/consts.dart';

Widget ourButton({onPress, color, textColor, String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: redColor,
          foregroundColor: whiteColor,
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
