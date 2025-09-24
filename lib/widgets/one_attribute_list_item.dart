import 'package:flutter/material.dart';
import 'package:main_app/screens/product_page/product_page.dart';
import 'package:main_app/widgets/one_attribute_list.dart';
class OneAttributeListItem extends StatelessWidget {
  final OneAttributeList product;

  const OneAttributeListItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProductPage()),
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imagePath,
                width: MediaQuery.of(context).size.width * 0.12307692307692307692307692307692,
                height: MediaQuery.of(context).size.width * 0.12307692307692307692307692307692,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6512,
                  child: Text(
                    product.name,
                    style: const TextStyle(fontSize: 14),
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    product.icon,
                    const SizedBox(width: 4),
                    Text(product.value,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: product.color,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text("در هر ${product.weight}",
                      style: const TextStyle(
                        color: Color(0xFF657380),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }


}


