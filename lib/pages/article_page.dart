import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detail_article.dart';
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';

class ArticlePage extends StatelessWidget {
  final List<Map<String, String>> articles = [
    {'image': 'assets/images/burung.jpg', 'title': 'Waspada Flu Burung!'},
    {
      'image': 'assets/images/kucing.jpg',
      'title': 'Cara Mudah Membuat Si Meong Sehat dan...',
    },
    {'image': 'assets/images/burung.jpg', 'title': 'Waspada Flu Burung!'},
    {
      'image': 'assets/images/kucing.jpg',
      'title': 'Cara Mudah Membuat Si Meong Sehat dan...',
    },
    {'image': 'assets/images/burung.jpg', 'title': 'Waspada Flu Burung!'},
    {
      'image': 'assets/images/kucing.jpg',
      'title': 'Cara Mudah Membuat Si Meong Sehat dan...',
    },
    {'image': 'assets/images/burung.jpg', 'title': 'Waspada Flu Burung!'},
    {
      'image': 'assets/images/kucing.jpg',
      'title': 'Cara Mudah Membuat Si Meong Sehat dan...',
    },
  ];

  ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        title: const Text(
          'Article',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder:
                    (context, index) =>
                        _buildArticleCard(context, articles[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color.fromARGB(255, 255, 255, 255), // Matches the doctor card
        child: const CustomBottomNavBar(currentIndex: 0),
      ),
    );
  }

  /// **Search Bar Widget**
  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  /// **Article Card Widget**
  Widget _buildArticleCard(BuildContext context, Map<String, String> article) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ArticleDetailPage(
                  title: article['title']!,
                  image: article['image']!,
                ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Card(
          color: const Color.fromARGB(
            255,
            253,
            253,
            253,
          ), // Slightly gray background
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8, // Increased for thicker shadow
          shadowColor: Colors.black45, // Darker shadow for visibility
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.asset(
                  article['image']!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  article['title']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
