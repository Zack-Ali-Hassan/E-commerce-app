import 'package:e_commerce_app/models/model.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class Latest_Products extends StatefulWidget {
  const Latest_Products({super.key, required this.product1});
  static const String id = "Latest_Products";
  final List<ProductModal> product1;

  @override
  State<Latest_Products> createState() => _Latest_ProductsState();
}

class _Latest_ProductsState extends State<Latest_Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text("Products"),
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
      body: ListView.builder(
        itemCount: widget.product1.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Latest_Products_Card(
            latest_product: widget.product1[index],
          );
        },
        // m
      ),
    );
  }
}

class Latest_Products_Card extends StatelessWidget {
  const Latest_Products_Card({
    super.key,
    required this.latest_product,
  });
  final ProductModal latest_product;

  @override
  Widget build(BuildContext context) {
    print(latest_product);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Expanded(
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: double.infinity,
                    width: 170,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(latest_product.image),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      left: 10,
                      right: 10,
                      top: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          latest_product.name,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          latest_product.description,
                          style: TextStyle(
                            fontSize: 8,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$" + latest_product.price,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 45,
                            ),
                            LikeButton(
                              size: 22,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
