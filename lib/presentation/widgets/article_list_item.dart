import 'package:flutter/material.dart';
import '../../data/models/article.dart';
import '../pages/article_detail_page.dart';

class ArticleListItem extends StatelessWidget {
  final Article article;

  const ArticleListItem({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (_, animation, __) {
              return FadeTransition(
                opacity: animation,
                child: ArticleDetailPage(article: article),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Hero(
          tag: article.urlToImage ?? article.title,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                if (article.urlToImage != null)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12), bottomLeft: Radius.circular(12)),
                    child: Image.network(
                      article.urlToImage!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return SizedBox(
                          width: 100,
                          height: 100,
                          child: Center(child: CircularProgressIndicator(value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes!
                              : null)),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey,
                        child: const Icon(Icons.broken_image, color: Colors.white),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey,
                    child: const Icon(Icons.image, color: Colors.white),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(article.title,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 8),
                        Text(article.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}