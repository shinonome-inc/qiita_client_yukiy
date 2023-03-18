import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/ui_components/tag_grid_view_cell.dart';

import '../models/tag.dart';

class TagGridView extends StatelessWidget {
  TagGridView({
    Key? key,
    required this.itemCount,
    required this.tagList,
    required this.scrollController,
  }) : super(key: key);

  final int itemCount;
  final List<Tag> tagList;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double columnWidth = 170;
    int columnCount = deviceSize.width ~/ columnWidth;
    return GridView.builder(
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        // 横1行あたりに表示するWidgetの数
        crossAxisCount: columnCount,
      ),
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        final tag = tagList[index];
        if (index == 0) {
          return TagGridViewCell(
            tag: tag,
          );
        }
        return TagGridViewCell(tag: tag);
      },
    );
  }
}
