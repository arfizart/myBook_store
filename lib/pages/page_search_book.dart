import 'package:flutter/material.dart';
import 'package:my_books_app/pages/page_detail_book.dart';
import '../api/api_book.dart';
import 'package:provider/provider.dart';

class BookSearchPage extends StatefulWidget {
  const BookSearchPage({Key? key, required this.searchText}) : super(key: key);
  final String searchText;
  @override
  State<BookSearchPage> createState() => _BookSearchPageState();
}

class _BookSearchPageState extends State<BookSearchPage> {
  BookController? bookController;

  @override
  void initState() {
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fetchSearchBookApi(widget.searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, provider, child) => Container(
          child: bookController!.searchBooks == null
              ? child
              : ListView.builder(
                  itemCount: bookController!.searchBooks!.books!.length,
                  itemBuilder: (context, index) {
                    final currentBook =
                        bookController!.searchBooks!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailBookPage(isbn: currentBook.isbn13!)));
                      },
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              currentBook.image!,
                              height: 100,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 12),
                                    Text(
                                      currentBook.title!,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      currentBook.subtitle!,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        currentBook.price!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.green,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
