import 'package:flutter/material.dart';
import 'package:my_books_app/api/api_book.dart';
import 'package:my_books_app/pages/page_detail_book.dart';
import 'package:my_books_app/pages/page_search_book.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;
  @override
  void initState() {
    super.initState();
    setState(() {
      bookController = Provider.of<BookController>(context, listen: false);
      bookController!.fetchBookApi();
      bookController!.fetchRekomenBookApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController myInputSearch = TextEditingController();
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(25),
          child: TextField(
            autofocus: false,
            autocorrect: false,
            showCursor: true,
            cursorColor: Colors.green,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.green,
              fontSize: 20,
            ),
            controller: myInputSearch,
            onSubmitted: (value) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BookSearchPage(searchText: value)));
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.green,
              )),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.green,
              )),
              prefixIcon: Icon(
                Icons.search,
                size: 35,
              ),
              labelText: "Search Book",
              labelStyle: TextStyle(color: Colors.green),
            ),
          ),
        ),
        //New Book
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    " New Books!",
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.green,
                  ),
                ],
              ),
              Text("See more >>", style: TextStyle(color: Colors.green)),
            ],
          ),
        ),
        //New Book
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          height: 340.0,
          child: bookController!.bookList == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final currentBook = bookController!.bookList!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailBookPage(isbn: currentBook.isbn13!),
                        ));
                      },
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                right: 15, left: 15, bottom: 20),
                            width: 200,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(4, 8),
                                ),
                              ],
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                image: NetworkImage(currentBook.image!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 60,
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        currentBook.title!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        currentBook.price! == '\$0.00'
                                            ? 'Free'
                                            : currentBook.price!,
                                        style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(margin: EdgeInsets.all(5)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        //Other Book
        Container(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Text(
                    " Other Books",
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  ),
                  Icon(
                    Icons.bookmark,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
        //other books list
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          height: 200.0,
          child: bookController!.rekomenBooks == null
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: bookController!.rekomenBooks!.books!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final cur = bookController!.rekomenBooks!.books![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailBookPage(isbn: cur.isbn13!),
                        ));
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 15, left: 15),
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green,
                          image: DecorationImage(
                            image: NetworkImage(cur.image!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black38,
                                ),
                                margin: EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Text(
                                      cur.title!,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      cur.subtitle!,
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        SizedBox(
          height: 55,
        ),
      ],
    );
  }
}
