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
  late bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    double columnWidth = 170;
    int columnCount = deviceSize.width ~/ columnWidth;
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: scrollController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              // 横1行あたりに表示するWidgetの数
              crossAxisCount: columnCount,
            ),
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              final tag = tagList[index];
              if (index == 0) {
                _isLoading = true;
                return TagGridViewCell(
                  tag: tag,
                );
              }
              return TagGridViewCell(tag: tag);
            },
          ),
        ),
        if (_isLoading) _loadingView(),
      ],
    );
  }
}

Widget _loadingView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      CircularProgressIndicator(),
      SizedBox(
        height: 8,
      )
    ],
  );
}
