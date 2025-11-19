import 'package:easy_download_manager/widget/status_category_card.dart';
import 'package:flutter/material.dart';

class FourStatusCategory extends StatelessWidget {
  const FourStatusCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) => StatusCategoryCard(),
    );
  }
}
