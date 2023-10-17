import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/models/category.dart';
import 'package:e_commerce_app/models/model.dart';
import 'package:e_commerce_app/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:http/http.dart' as http;

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});
  static const String id = "home_screen";
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  final String endPoint = "http://192.168.2.69/mobile/products.php";
  List<CategoryModel> CategoryData = [];

  List<ProductModal> productData = [];
  Future<List<CategoryModel>> getCategories() async {
    List<CategoryModel> categoryModel = [];
    try {
      http.Response response = await http.post(
        Uri.parse(endPoint),
        body: {
          'action': 'getCategories',
        },
      );
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        categoryModel = data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        print(response.body);
      }
    } on SocketException {
      print("No Internet connection");
    } catch (e) {
      print(e.toString());
    }
    return categoryModel;
  }

  Future<List<ProductModal>> getProducts() async {
    List<ProductModal> product = [];
    try {
      http.Response response = await http.post(Uri.parse(endPoint), body: {
        'action': 'getProducts',
      });
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        product = data.map((e) => ProductModal.fromJson(e)).toList();
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text("Dukaan App"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_basket),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Carousel(
                    images: [
                      AssetImage("assets/images/1.jpg"),
                      AssetImage("assets/images/2.jpg"),
                      AssetImage("assets/images/3.jpg"),
                      AssetImage("assets/images/9.jpg"),
                      AssetImage("assets/images/10.jpg"),
                      AssetImage("assets/images/7.jpg"),
                      AssetImage("assets/images/8.jpg"),
                      AssetImage("assets/images/6.jpg"),
                    ],
                    dotSize: 6.0,
                    dotSpacing: 15.0,
                    dotColor: Colors.lightGreenAccent,
                    indicatorBgPadding: 2.0,
                    dotBgColor: Colors.black.withOpacity(0.5),
                    hasBorderRadius: true,
                    moveIndicatorFromBottom: 180.0,
                    noRadiusForIndicator: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 12),
                          child: Text(
                            "Product categories",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            CategoryData.isEmpty
                                ? null
                                : Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => View_Category(
                                              category: CategoryData,
                                            )));
                          },
                          child: Text(
                            "See all",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: SizedBox(
                        height: 130,
                        child: FutureBuilder<List<CategoryModel>>(
                          future: getCategories(),
                          builder: (context, snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              default:
                                if (snapshot.hasData) {
                                  CategoryData = snapshot.data!;
                                  return ListView.separated(
                                    padding: EdgeInsets.all(12),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: CategoryData.length,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        width: 12,
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return Category_Card(
                                        category: CategoryData[index],
                                      );
                                    },
                                  );
                                } else {
                                  return Center(
                                    child: Text("No data Founded.."),
                                  );
                                }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 12),
                            child: Text(
                              "Latest Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              productData.isEmpty
                                  ? null
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Latest_Products(
                                                product1: productData,
                                              )));
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 5),
                        child: SizedBox(
                          height: 280,
                          child: FutureBuilder(
                            future: getProducts(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                default:
                                  if (snapshot.hasData) {
                                    productData = snapshot.data!;
                                    return ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: productData.length,
                                      separatorBuilder: (context, index) {
                                        return const SizedBox(
                                          width: 12,
                                        );
                                      },
                                      itemBuilder: (context, index) {
                                        return Latest_Product_Card(
                                          product: productData[index],
                                        );
                                      },
                                    );
                                  } else {
                                    return Center(
                                      child: Text("No data has founded.."),
                                    );
                                  }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Latest_Product_Card extends StatelessWidget {
  const Latest_Product_Card({
    super.key,
    required this.product,
  });
  final ProductModal product;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 241, 241, 241),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Product_Screen(
                      productModal: product,
                    )),
          );
        },
        child: Container(
          width: 150,
          height: 280,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 140,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                product.price + "\$",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Category_Card extends StatelessWidget {
  const Category_Card({
    super.key,
    required this.category,
  });
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 241, 241, 241),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {},
        child: Container(
          width: 90,
          height: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage(category.thumbnail),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
