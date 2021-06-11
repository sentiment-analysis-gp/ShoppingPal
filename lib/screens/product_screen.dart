import 'package:flutter/material.dart';
import 'package:shopping_pal/constants.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shopping_pal/models/product.dart';
import 'package:shopping_pal/models/product_reviews.dart';
import 'package:shopping_pal/services/databaseService.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import '../models/product_info.dart';
import '../services/networking.dart';
import 'shared/search_appbar.dart';

class ProductScreen extends StatefulWidget {
  Product product;
  ProductInfo productInfo;
  ProductReviews productReviews;
  ProductScreen({this.product, this.productInfo, this.productReviews});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final DatabaseService _dbService = DatabaseService();
  @override
  void initState() {
    super.initState();
    initProductReviews();
  }

  double modelRating = 0;
  Future<void> initProductReviews() async {
    widget.productReviews = await Networking().getModelData();
    setState(() {
      widget.productReviews;
      modelRating = widget.productReviews.productModelRating;
      print(modelRating);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Positive": widget?.productReviews?.numberOfPosReviews?.toDouble() ?? 0,
      "Negative": widget?.productReviews?.numberOfNegReviews?.toDouble() ?? 0,
      "Neutral": widget?.productReviews?.numberOfNeutReviews?.toDouble() ?? 0,
    };
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: SearchAppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      CircleAvatar(
                        backgroundColor: kSecondaryColor,
                        radius: size.width * 0.2 + 3.0,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: (widget.productInfo.productImageURL
                                      ?.isNotEmpty ??
                                  false)
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.5),
                                  child: InkWell(
                                    splashColor: Colors.white,
                                    radius: size.width * 0.5,
                                    child: Image.network(
                                      widget.productInfo.productImageURL,
                                      width: size.width * 0.6,
                                      height: size.width * 0.6,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                )
                              : Icon(
                                  Icons.shopping_bag_outlined,
                                  color: kPrimaryColor,
                                  size: size.width * 0.2,
                                ),
                          radius: size.width * 0.2,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20, top: 5),
                        width: 50,
                        height: 35,
                        child: RawMaterialButton(
                          onPressed: () {
                            _dbService.addProductToWishList(widget.product);
                          },
                          elevation: 2.0,
                          fillColor: kPrimaryColor,
                          child: Icon(
                            Icons.add,
                            size: 20.0,
                            color: Colors.white,
                          ),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Text(
                    widget.productInfo.productName,
                    textAlign: TextAlign.center,
                    style: kSecondaryTextStyle.copyWith(color: kPrimaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: Text(
                    'Price : ' +
                        widget.productInfo.productPrice.toString() +
                        ' \$',
                    textAlign: TextAlign.center,
                    style: kSecondaryTextStyle.copyWith(color: kPrimaryColor),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          ExactAssetImage("assets/images/amazon_logo.png"),
                      radius: size.width * 0.05,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget.productInfo.productAmazonRating.toString()),
                    SizedBox(
                      width: 10,
                    ),
                    SmoothStarRating(
                        allowHalfRating: false,
                        defaultIconData: Icons.star_outline,
                        filledIconData: Icons.star,
                        halfFilledIconData: Icons.star_half,
                        starCount: 5,
                        rating: double.parse(
                            widget.productInfo.productAmazonRating),
                        size: 40.0,
                        isReadOnly: true,
                        color: kPrimaryColor,
                        borderColor: kSecondaryColor,
                        spacing: 0.0),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: kSecondaryColor,
                  thickness: 1.0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'Customer Reviews',
                  style: kSecondaryTextStyle.copyWith(
                      color: kPrimaryColor, fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          ExactAssetImage("assets/images/launcher_icon.png"),
                      radius: size.width * 0.05,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(widget?.productReviews?.productModelRating
                            ?.toString() ??
                        '..'),
                    SizedBox(
                      width: 10,
                    ),
                    widget.productReviews == null
                        ? Text('') //honda liko was here
                        : SmoothStarRating(
                            allowHalfRating: false,
                            defaultIconData: Icons.star_outline,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            starCount: 5,
                            rating: widget.productReviews.productModelRating,
                            size: 40.0,
                            isReadOnly: true,
                            color: kPrimaryColor,
                            borderColor: kSecondaryColor,
                            spacing: 0.0,
                          ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                PieChart(
                  dataMap: dataMap,
                  colorList: colorList,
                  chartRadius: size.width * 0.4,
                ),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sentiment_satisfied_alt,
                        color: kSecondaryColor,
                        size: 60,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        widget?.productReviews?.posSample ?? 'Positive Review',
                        style: kSecondaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sentiment_neutral_outlined,
                        color: kMiddleColor,
                        size: 60,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        widget?.productReviews?.neutSample ?? 'Neutral Review',
                        style: kSecondaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sentiment_dissatisfied_outlined,
                        color: kPrimaryColor,
                        size: 60,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        widget?.productReviews?.negSample ?? 'Negative Review',
                        style: kSecondaryTextStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
