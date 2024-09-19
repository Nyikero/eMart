import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  switchcategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubcategoryProducts(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  @override
  void initState() {
    switchcategory(widget.title);
    super.initState();
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: whiteColor),
              title: widget.title!.text.fontFamily(bold).white.make(),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: List.generate(
                            controller.subcat.length,
                            (index) => "${controller.subcat[index]}"
                                    .text
                                    .size(12)
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .makeCentered()
                                    .box
                                    .white
                                    .rounded
                                    .size(120, 60)
                                    .margin(const EdgeInsets.only(right: 8))
                                    .make()
                                    .onTap(() {
                                  switchcategory("${controller.subcat[index]}");
                                  setState(() {});
                                }))),
                  ),
                  20.heightBox,
                  StreamBuilder(
                      stream: productMethod,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Expanded(
                            child: Center(
                              child: loadingIndicator(),
                            ),
                          );
                        } else if (snapshot.data!.docs.isEmpty) {
                          return Expanded(
                            child: "No products found."
                                .text
                                .color(darkFontGrey)
                                .makeCentered(),
                          );
                        } else {
                          var data = snapshot.data!.docs;

                          return Expanded(
                            child: GridView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisExtent: 250,
                                            mainAxisSpacing: 12,
                                            crossAxisSpacing: 12),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                                  data[index]['p_imgs'][0],
                                                  width: 200,
                                                  height: 150,
                                                  fit: BoxFit.cover)
                                              .box
                                              .clip(Clip.antiAlias)
                                              .roundedSM
                                              .make(),
                                          "${data[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          "${data[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make()
                                        ],
                                      )
                                          .box
                                          .white
                                          .roundedSM
                                          .shadowSm
                                          .padding(const EdgeInsets.all(12))
                                          .make()
                                          .onTap(() {
                                        controller.checkIfFav(data[index]);
                                        Get.to(() => ItemDetails(
                                            title: "${data[index]['p_name']}",
                                            data: data[index]));
                                      });
                                    })
                                .box
                                .margin(const EdgeInsets.only(right: 12))
                                .make(),
                          );
                        }
                      }),
                ],
              ),
            )));
  }
}
