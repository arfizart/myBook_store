import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/bookdetail_response.dart';
import '../models/booklist_response.dart';
import 'package:http/http.dart' as http;

class BookController extends ChangeNotifier {
  BookListResponse? bookList;
  BookListResponse? similarBooks;
  BookListResponse? rekomenBooks;
  BookListResponse? searchBooks;
  BookDetailResponse? detailBook;

  fetchBookApi() async {
    var url = Uri.https('api.itbook.store', '1.0/new');
    var response = await http.post(url);
    if (response.statusCode == 200) {
      final jsonBookList = jsonDecode(response.body);
      bookList = BookListResponse.fromJson(jsonBookList);
      notifyListeners();
    }
  }

  fetchDetailBookApi(isbn) async {
    var url = Uri.https('api.itbook.store', '/1.0/books/$isbn');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      detailBook = BookDetailResponse.fromJson(jsonDetail);
      fetchSimilarBookApi(detailBook!.title!);
      notifyListeners();
    }
  }

  fetchSimilarBookApi(String title) async {
    var url = Uri.https('api.itbook.store', '/1.0/search/$title');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      similarBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }

  fetchRekomenBookApi() async {
    var url = Uri.https('api.itbook.store', '/1.0/search/programing');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      rekomenBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }

  fetchSearchBookApi(String title) async {
    var url = Uri.https('api.itbook.store', '/1.0/search/$title');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonDetail = jsonDecode(response.body);
      searchBooks = BookListResponse.fromJson(jsonDetail);
      notifyListeners();
    }
  }
}
