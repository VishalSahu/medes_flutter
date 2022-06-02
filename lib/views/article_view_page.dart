import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medes/model/article_model.dart';

class ArticleReadPage extends StatelessWidget {
  final HealthApiModel model;
  const ArticleReadPage({required this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                  ),
                  child: Text(
                    model.title,
                    style: GoogleFonts.poppins(
                        fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '- ' + model.author,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepPurple,
                      ),
                    ),
                    model.publishedAt != ""
                        ? Text(
                            model.publishedAt.substring(0, 10),
                          )
                        : const Text(""),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  child: Image.network(
                    model.imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  model.description,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  color: Colors.deepPurple,
                  height: 150,
                  thickness: 1,
                  indent: 100,
                  endIndent: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
