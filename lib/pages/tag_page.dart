import 'package:flutter/material.dart';
import 'package:qiita_client_yukiy/models/tag.dart';
import 'package:qiita_client_yukiy/services/qiita_client.dart';
import 'package:qiita_client_yukiy/ui_components/tag_grid_view.dart';
import 'package:qiita_client_yukiy/ui_components/upper_bar.dart';

class TagPage extends StatefulWidget {
  TagPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  List<Tag> listTags = [];
  late bool _isLoading = true;
  int pageNumber = 1;
  late Future<List<Tag>> futureTags;

  @override
  void initState() {
    _fetchTagData();
    super.initState();
  }

  Future<void> _fetchTagData() async {
    _isLoading = false;
    futureTags = QiitaClient.fetchTags(pageNumber);
    listTags.addAll(await futureTags);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UpperBar(
        showSearchBar: false,
        appBarText: 'Tags',
        textField: TextField(),
      ),
      body: FutureBuilder<List<Tag>>(
        future: QiitaClient.fetchTags(pageNumber),
        builder: (context, snapshot) {
          return TagGridView(
            tagList: listTags,
            itemCount: _isLoading ? listTags.length + 1 : listTags.length,
          );
        },
      ),
    );
  }
}
