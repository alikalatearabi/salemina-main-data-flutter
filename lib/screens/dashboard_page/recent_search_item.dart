import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:main_app/screens/dashboard_page/recent_search.dart';
class RecentSearchItem extends StatelessWidget {
  final RecentSearch product;

  const RecentSearchItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            crossAxisAlignment: CrossAxisAlignment.end,
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
                  SvgPicture.asset(
                    'assets/icons/fire 2.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 2),
                  Text(product.calories,
                    style: const TextStyle(fontSize: 12),
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
    );
  }


}


