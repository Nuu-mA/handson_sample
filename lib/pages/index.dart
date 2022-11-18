import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:template_flutter/model/issue.dart';
import 'package:template_flutter/model/repository.dart';
import 'package:template_flutter/pages/issue_info.dart';
import 'package:template_flutter/repositories/github_repository.dart';

class IssueListPage extends StatelessWidget {
  const IssueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: fetchIssues(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        // 通信にエラーが発生した場合
        if (snapshot.hasError) {
          return Center(child: Text('Error : ${snapshot.error}'));
        }

        // 通信に成功も、データが存在しなかった場合
        if (snapshot.data == null) {
          return const Text('No issues');
        }

        // 通信に成功し、無事にデータをフェッチできた場合
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            final Issue issue = snapshot.data[index];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CardItem(
                id: issue.id,
                title: issue.title,
                message: issue.body ?? '',
                url: issue.url,
                updatedAt: issue.updatedAt,
              ),
            );
          },
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.id,
    required this.title,
    required this.message,
    required this.url,
    required this.updatedAt,
  });
  final String? id;
  final String title;
  final String message;
  final String url;
  final String updatedAt;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                  Text(
                    updatedAt,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
            // IconButtonを設定する
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return IssueInputPage(
                      id: id,
                      title: title,
                      body: message,
                    );
                  },
                ),
              ),
              icon: const Icon(
                Icons.create_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
