import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/models/article.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({super.key, required this.article});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: article.urlToImage ?? article.title,
              child: article.urlToImage != null
                  ? Image.network(
                article.urlToImage!,
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              )
                  : Container(
                width: double.infinity,
                height: 220,
                color: Colors.grey,
                child: const Icon(Icons.image, size: 80, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                article.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            if (article.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  article.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => _launchURL(article.url),
                child: const Text('Read More'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}