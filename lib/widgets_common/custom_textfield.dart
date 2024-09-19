import 'package:e_mart/consts/consts.dart';

Widget customTextField(
    {controller, isPass, label, textInputAction, fillColor}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //title!.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        textInputAction: textInputAction,
        obscureText: isPass,
        controller: controller,
        cursorColor: redColor,
        decoration: InputDecoration(
            label: label,
            labelStyle: const TextStyle(color: redColor),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor)),
            // hintStyle:
            //     const TextStyle(fontFamily: semibold, color: textfieldGrey),
            //hintText: hint,
            isDense: true,
            fillColor: fillColor,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: redColor))),
      ),
      5.heightBox
    ],
  );
}
