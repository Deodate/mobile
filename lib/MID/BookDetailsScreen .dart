import 'package:flutter/material.dart';

class BookDetailsScreen extends StatelessWidget {
   final String imagePath;
  final String title;
  final String author;
  final double rating;
  final String description;
  final String datePublished;
  final String cityPublished;
  final String pages;

  const BookDetailsScreen({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.author,
    required this.rating,
    required this.description,
    required this.datePublished,
    required this.cityPublished,
    required this.pages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('path_to_author_image.jpg'),
                    radius: 30,
                  ),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    author,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "NEW YORK TIMES BESTSELLING AUTHORS",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text('Want to read', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            // Implement 'Want to read' functionality
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          child: Text('Get a copy'),
                          onPressed: () {
                            // Implement 'Get a copy' functionality
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 8),
                  Text(
                    author,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (index) => Icon(
                          index < rating.floor() ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(rating.toString()),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
