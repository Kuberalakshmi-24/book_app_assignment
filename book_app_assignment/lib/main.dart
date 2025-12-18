import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 1. Book model class
class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book List Assignment',
      debugShowCheckedModeBanner: false, // Debug banner removed for professional look
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Professional color
        useMaterial3: true,
      ),
      home: const BookListScreen(),
    );
  }
}

class BookListScreen extends StatefulWidget {
  const BookListScreen({super.key});

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  // Initial list of books
  final List<Book> _books = [
    Book(title: 'The Great Gatsby', author: 'F. Scott Fitzgerald'),
    Book(title: '1984', author: 'George Orwell'),
    Book(title: 'To Kill a Mockingbird', author: 'Harper Lee'),
  ];

  // Controllers to get user input
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  // Function to show Dialog and Add Book
  void _showAddBookDialog() {
    // Clear old text every time dialog opens
    _titleController.clear();
    _authorController.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Book'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Input for Book Title
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Book Title',
                  hintText: 'Enter book name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              // Input for Author Name
              TextField(
                controller: _authorController,
                decoration: const InputDecoration(
                  labelText: 'Author Name',
                  hintText: 'Enter author name',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            // Cancel Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            // Add Button
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty &&
                    _authorController.text.isNotEmpty) {
                  setState(() {
                    _books.add(
                      Book(
                        title: _titleController.text,
                        author: _authorController.text,
                      ),
                    );
                  });
                  Navigator.of(context).pop(); // Close dialog after adding
                }
              },
              child: const Text('Add Book'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up controllers to free memory (Good practice for interviews)
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Book List', 
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      // 3. ListView.builder
      body: _books.isEmpty 
          ? const Center(child: Text("No books added yet!")) 
          : ListView.builder(
              itemCount: _books.length,
              itemBuilder: (context, index) {
                final book = _books[index];
                return Card(
                  elevation: 3, // Shadow effect
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple.shade100,
                      child: const Icon(Icons.book, color: Colors.deepPurple),
                    ),
                    title: Text(
                      book.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("by ${book.author}"),
                  ),
                );
              },
            ),
      // 4. Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBookDialog, // Call the dialog function
        backgroundColor: Colors.deepPurple,
        tooltip: 'Add Book',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}