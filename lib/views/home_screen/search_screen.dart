import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: title!.text.color(darkFontGrey).make(),
          ),
          body: FutureBuilder(
              future: FirestoreServices.searchProducts(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return "No products found".text.makeCentered();
                } else {
                  var data = snapshot.data!.docs;
                  var filtered = data
                      .where((element) => element['p_name']
                          .toString()
                          .toLowerCase()
                          .contains(title!.toLowerCase()))
                      .toList();
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: GridView(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 300,
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8),
                        children: filtered
                            .mapIndexed((currentValue, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        "${filtered[index]['p_imgs'][0]}",
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover),
                                    const Spacer(),
                                    "${filtered[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    "${filtered[index]['p_price']}"
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
                                    .outerShadowMd
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                      title: "${filtered[index]['p_name']}",
                                      data: filtered[index]));
                                }))
                            .toList()),
                  );
                }
              })),
    );
  }
}
