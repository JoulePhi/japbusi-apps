import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';
import 'package:japbusi/app/utils/app_colors.dart';
import 'package:japbusi/app/utils/app_formatter.dart';
import 'package:japbusi/app/utils/app_text_styles.dart';

import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleDetailController> {
  const ArticleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Artikel'),
        centerTitle: true,
        backgroundColor: AppColors.successColor,
      ),
      body: Obx(
        () => controller.isArticleLoading.value
            ? Center(child: CircularProgressIndicator())
            : controller.article.value == null
            ? Center(child: Text('Artikel tidak ditemukan'))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.article.value!.title,
                        style: AppTextStyles.body2.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Oleh ${controller.article.value!.author} - ${AppFormatter.formatDate(controller.article.value!.createdAt)}',
                        style: AppTextStyles.body2.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 16),
                      CachedNetworkImage(
                        imageUrl: controller.article.value!.thumbnail,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 200,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      SizedBox(height: 16),
                      if (controller.article.value!.content != null)
                        Html(data: controller.article.value!.content!),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
