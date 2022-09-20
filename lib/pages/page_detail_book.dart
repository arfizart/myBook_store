import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../api/api_book.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({super.key, required this.isbn});
  // static const nameRoute = '/detailbook';
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? bookController;

  @override
  void initState() {
    super.initState();
    setState(() {
      bookController = Provider.of<BookController>(context, listen: false);
      bookController!.fetchDetailBookApi(widget.isbn);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Book Page"),
      ),
      body: bookController!.detailBook == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView(
                children: [
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          bookController!.detailBook!.image!,
                          width: 250,
                        ),
                        Container(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 300,
                              child: Text(
                                bookController!.detailBook!.title!,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              bookController!.detailBook!.price!,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          ],
                        ),
                        Container(
                          height: 10,
                        ),
                        Text(
                          "By ${bookController!.detailBook!.authors!}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            5,
                            (index) => Icon(
                              Icons.star,
                              color: index <
                                      int.parse(
                                          bookController!.detailBook!.rating!)
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                Text(bookController!.detailBook!.subtitle!),
                                Text(
                                  bookController!.detailBook!.desc!,
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            Container(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: () async {
                                  Uri uri = Uri.parse(
                                      bookController!.detailBook!.url!);
                                  try {
                                    await canLaunchUrl(uri)
                                        ? launchUrl(uri)
                                        : print("Link Invalid");
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text('Buy this book'),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Text('Other Books'),
                        Consumer(builder: (context, provider, child) {
                          return bookController!.similarBooks == null
                              ? const Center(child: CircularProgressIndicator())
                              : Container(
                                  height: 150,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: bookController!
                                        .similarBooks!.books!.length,
                                    itemBuilder: (context, index) {
                                      final current = bookController!
                                          .similarBooks!.books![index];
                                      return Container(
                                        width: 100,
                                        child: Column(children: [
                                          Image.network(
                                            current.image!,
                                          ),
                                          Text(
                                            current.title!,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),
                                          ),
                                        ]),
                                      );
                                    },
                                  ),
                                );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
