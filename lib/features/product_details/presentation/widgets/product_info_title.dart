import 'package:flutter/material.dart';

class ProductInfoTitle extends StatelessWidget {
  const ProductInfoTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) =>  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: SizedBox(
          width: 178,
          child: Text(
            // 'Thin Choise Top Orange',
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
}
