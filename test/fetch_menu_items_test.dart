import 'package:apitesting/fetch_menu_items.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'fetch_menu_items_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
  });

  tearDown(() {
    mockClient.close();
  });
  group('fetch menuitems api call test', () {
    test('Should return list of menu items for http success call', () async {
      // ARRANGE
      Content content = Content(
          id: 0,
          name: "name",
          price: "price",
          decription: "decription",
          currencyunit: "currencyunit",
          imagename: "imagename",
          uuid: "uuid",
          deleted: "deleted",
          publishdate: "publishdate",
          unpublishdate: "unpublishdate",
          menuorder: "menuorder");

      List<Content> contentList = List.filled(10, content);

      when(mockClient.get(Uri.parse(fetchMenuItemsURL))).thenAnswer(
          (realInvoication) async =>
              http.Response('[{"id":0,"name":"Trileche"}]', 200));

      // ACT & ASSERT
      expect(await fetchMenuItems(mockClient), isA<List<MenuItemListModel>>());
    });

    test(
        'Should throw an exception when http api call is completed with an error ',
        () async {
      // ARRANGE

      when(mockClient.get(Uri.parse(fetchMenuItemsURL))).thenAnswer(
          (realInvoication) async => http.Response('Not Found', 404));

      expect(await fetchMenuItems(mockClient), throwsException);
    });
  });
}
