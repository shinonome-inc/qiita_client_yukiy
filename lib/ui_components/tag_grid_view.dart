import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/tag_grid_view_cell.dart';

import '../models/tag.dart';

class TagGridView extends StatelessWidget {
  const TagGridView({
    Key? key,
    required this.itemCount,
    required this.tagList,
  }) : super(key: key);

  final int itemCount;
  final List<Tag> tagList;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double columnWidth = 170;
    int columnCount = deviceSize.width ~/ columnWidth;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 横1行あたりに表示するWidgetの数
        crossAxisCount: columnCount,
      ),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        final tag = tagList[index];
        return TagGridViewCell(
          tag: tag,
        );
      },
    );
  }
}
