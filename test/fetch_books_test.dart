import 'package:apitesting/fetch_books.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'fetch_books_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetch books api call test', () {
    test('Should return list of books for http success call', () async {
      // ARRANGE
      final mockClient = MockClient();

      when(mockClient.get(Uri.parse(fetchBooksURL))).thenAnswer(
          (realInvoication) async => http.Response(
              '[{"name":"mock_name", "author":"mockauthor","description":"mockdesc","amazon":"mockamzn"}]',
              200));

      // ACT & ASSERT
      expect(await fetchBooks(mockClient), isA<List<BooksListModel>>());
    });

    test(
        'Should throw an exception when http api call is completed with an error ',
        () async {
      // ARRANGE
      final mockClient = MockClient();

      when(mockClient.get(Uri.parse(fetchBooksURL))).thenAnswer(
          (realInvoication) async => http.Response('Not Found', 404));

      expect(await fetchBooks(mockClient), throwsException);
    });
  });
}
