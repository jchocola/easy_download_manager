import 'package:easy_download_manager/widget/status_category_card.dart';
import 'package:flutter/material.dart';

class FourStatusCategory extends StatelessWidget {
  const FourStatusCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(flex: 1, child: StatusCategoryCard()),
            Expanded(flex: 1, child: StatusCategoryCard()),
          ],
        ),

        Row(
          children: [
            Expanded(flex: 1, child: StatusCategoryCard()),
            Expanded(flex: 1, child: StatusCategoryCard()),
          ],
        ),
      ],
    );
  }
}
