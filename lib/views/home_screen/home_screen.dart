import 'package:e_mart/consts/consts.dart';
import 'package:e_mart/views/home_screen/search_screen.dart';
import 'package:e_mart/widgets_common/loading_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: redColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: redColor,
    ));
    var controller = Get.find<HomeController>();
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: Column(
        children: [
          Container(
              alignment: Alignment.center,
              //height: 60,
              color: lightGrey,

              // Search Box

              child: SafeArea(
                child: TextFormField(
                  controller: controller.searchController,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: redColor,
                  decoration: InputDecoration(
                      enabledBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      focusedBorder:
                          const OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: const Icon(Icons.search).onTap(() {
                        if (controller
                            .searchController.text.isNotEmptyAndNotNull) {
                          Get.to(() => SearchScreen(
                                title: controller.searchController.text,
                              ));
                        }
                      }),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchAnything,
                      hintStyle: const TextStyle(color: textfieldGrey)),
                ),
              )),

          //Swiper Brands
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 12),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  VxSwiper.builder(
                      viewportFraction: 1.0,
                      autoPlay: true,
                      height: 150,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersList[index],
                          fit: BoxFit.cover,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 12))
                            .clip(Clip.antiAlias)
                            .make();
                      }),

                  // Deals Buttons
                  12.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.1,
                            width: context.screenWidth / 2.2,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todaysDeal : flashSale)),
                  ),

                  // Second Swiper
                  12.heightBox,
                  VxSwiper.builder(
                      viewportFraction: 1.0,
                      autoPlay: true,
                      height: 150,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.cover,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 12))
                            .clip(Clip.antiAlias)
                            .make();
                      }),

                  // Category Buttons
                  12.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homeButtons(
                              height: context.screenHeight * 0.1,
                              width: context.screenWidth / 3.4,
                              icon: index == 0
                                  ? icTopCategories
                                  : index == 1
                                      ? icBrands
                                      : icTopSeller,
                              title: index == 0
                                  ? topCategories
                                  : index == 1
                                      ? brand
                                      : topSellers))),

                  12.heightBox,

                  // Featured Categories
                  // 24.heightBox,
                  // Align(
                  //     alignment: Alignment.centerLeft,
                  //     child: featuredCategories.text
                  //         .color(darkFontGrey)
                  //         .size(18)
                  //         .fontFamily(semibold)
                  //         .make()
                  //         .box
                  //         .margin(const EdgeInsets.only(left: 12))
                  //         .make()),

                  // Featured Buttons

                  // SingleChildScrollView(
                  //     padding: const EdgeInsets.only(
                  //         left: 12, top: 12, bottom: 12),
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //         children: List.generate(
                  //             3,
                  //             (index) => Column(
                  //                   children: [
                  //                     featuredButton(
                  //                         icon: featuredImages1[index],
                  //                         title: featuredTiles1[index]),
                  //                     12.heightBox,
                  //                     featuredButton(
                  //                         icon: featuredImages2[index],
                  //                         title: featuredTiles2[index]),
                  //                   ],
                  //                 )))),

                  // Featured Product

                  Container(
                    padding: const EdgeInsets.only(
                        top: 12, left: 12, right: 12, bottom: 24),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: golden),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        featuredProduct.text
                            .color(Colors.black)
                            .fontFamily(bold)
                            .size(18)
                            .make(),
                        12.heightBox,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No featured products"
                                      .text
                                      .white
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                      "${featuredData[index]['p_imgs'][0]}",
                                                      width: 150,
                                                      height: 150,
                                                      fit: BoxFit.cover),
                                                  12.heightBox,
                                                  "${featuredData[index]['p_name']}"
                                                      .text
                                                      .fontFamily(semibold)
                                                      .color(darkFontGrey)
                                                      .make(),
                                                  "${featuredData[index]['p_price']}"
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
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .roundedSM
                                                  .padding(
                                                      const EdgeInsets.all(8))
                                                  .make()
                                                  .onTap(() {
                                                Get.to(() => ItemDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index]));
                                              })));
                                }
                              }),
                        )
                      ],
                    ),
                  ),

                  // Third Swiper
                  12.heightBox,
                  VxSwiper.builder(
                      viewportFraction: 1.0,
                      autoPlay: true,
                      height: 150,
                      itemCount: secondSlidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersList[index],
                          fit: BoxFit.cover,
                        )
                            .box
                            .rounded
                            .margin(const EdgeInsets.symmetric(horizontal: 12))
                            .clip(Clip.antiAlias)
                            .make();
                      }),

                  // All products Section
                  StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allProductsdata = snapshot.data!.docs;
                          return GridView.builder(
                              padding: const EdgeInsets.all(12),
                              shrinkWrap: true,
                              itemCount: allProductsdata.length,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      mainAxisExtent: 300),
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                            "${allProductsdata[index]['p_imgs'][0]}",
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover)
                                        .box
                                        .clip(Clip.antiAlias)
                                        .roundedSM
                                        .make(),
                                    const Spacer(),
                                    "${allProductsdata[index]['p_name']}"
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    "${allProductsdata[index]['p_price']}"
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
                                    .shadowSm
                                    .roundedSM
                                    .padding(const EdgeInsets.all(12))
                                    .make()
                                    .onTap(() {
                                  Get.to(() => ItemDetails(
                                      title:
                                          "${allProductsdata[index]['p_name']}",
                                      data: allProductsdata[index]));
                                });
                              });
                        }
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
