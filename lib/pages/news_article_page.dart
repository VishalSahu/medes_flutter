// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medes/model/article_model.dart';
import 'package:medes/services/health_articles.dart';
import 'package:medes/views/article_view_page.dart';

class NewsArticlePage extends StatefulWidget {
  const NewsArticlePage({Key? key}) : super(key: key);

  @override
  State<NewsArticlePage> createState() => _NewsArticlePageState();
}

class _NewsArticlePageState extends State<NewsArticlePage> {
  List<HealthApiModel>? articlesList;
  bool isLoading = true;
  @override
  void initState() {
    getArticles().then((value) => {
          setState(() {
            if (value.isNotEmpty) {
              articlesList = value;
              isLoading = false;
            } else {}
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.deepPurple, //change your color here
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'Trending Articles',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: articlesList!.length,
                      itemBuilder: (context, index) {
                        return listItems(size, articlesList![index]);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget listItems(Size size, HealthApiModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.5),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ArticleReadPage(
              model: model,
            ),
          ),
        ),
        child: Container(
          height: size.height / 3,
          width: size.width / 1.15,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 10),
                blurRadius: 15,
                color: Colors.deepPurple.withOpacity(0.15),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: model.imageUrl != ""
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            model.imageUrl,
                            fit: BoxFit.fitWidth,
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://eagle-sensors.com/wp-content/uploads/unavailable-image.jpg',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                ),
                model.title != ""
                    ? Text(
                        model.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text('Title is unavailable'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    model.author != ""
                        ? Text(
                            ' - ' + model.author,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          )
                        : const Text('Author is unavailable'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
