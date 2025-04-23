import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_app/features/daily_news/domain/entities/article.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;

  const ArticleWidget({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    if (article == null) {
      // Handle the case where the article is null, e.g., show a placeholder
      return Center(child: Text("No article data available"));
    }

    return Container(
      padding: const EdgeInsetsDirectional.only(
        start: 14,
        end: 14,
        bottom: 10,
        top: 10,
      ),
      height: MediaQuery.of(context).size.height / 2.2,
      child: Row(
        children: [_buildImage(context), _buildTitleAndDescription(context)],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (article?.urlToImage == null) {
      // Fallback image if `urlToImage` is null
      return Padding(
        padding: const EdgeInsetsDirectional.only(end: 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            height: double.maxFinite,
            color: Colors.grey[300], // Placeholder color
            child: const Icon(
              Icons.image,
              color: Colors.white,
            ), // Fallback icon
          ),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: article!.urlToImage!,
      imageBuilder:
          (context, imageProvider) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
      progressIndicatorBuilder:
          (context, url, downloadProgress) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                child: const CupertinoActivityIndicator(),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                ),
              ),
            ),
          ),
      errorWidget:
          (context, url, error) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                child: const Icon(Icons.error),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildTitleAndDescription(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              article?.title?.isNotEmpty ?? false
                  ? article!.title!
                  : 'No Title Available',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Butler',
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),

            // Desc
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  article?.description ?? 'No Description Available',
                  maxLines: 2,
                ),
              ),
            ),

            // Date
            Row(
              children: [
                const Icon(Icons.timeline_outlined, size: 16),
                const SizedBox(width: 4),
                Text(
                  article?.publishedAt ?? 'No Date Available', // Fallback date
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
