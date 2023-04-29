import 'dart:convert';
import 'package:http/http.dart' as http;

String fetchMenuItemsURL = 'http://afroditsoftwarehouse/api/test/all/menucategory';

Future<List<MenuItemListModel>> fetchMenuItems(http.Client client) async {
  final response = await client.get(Uri.parse(fetchMenuItemsURL)); // Call API

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return List<MenuItemListModel>.from(
        json.decode(response.body).map((x) => MenuItemListModel.fromJson(x)));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load menu');
  }
}

class Content {
  Content(
      {required this.id,
      required this.name,
      required this.price,
      required this.decription,
      required this.currencyunit,
      required this.imagename,
      required this.uuid,
      required this.deleted,
      required this.publishdate,
      required this.unpublishdate,
      required this.menuorder});

  int id;
  String name;
  String price;
  String decription;
  String currencyunit;
  String imagename;
  String uuid;
  String deleted;
  String publishdate;
  String unpublishdate;
  String menuorder;
}

class MenuItemListModel {
  MenuItemListModel({required this.content});
  List<Content> content;

  factory MenuItemListModel.fromJson(Map<Content, dynamic> json) =>
      MenuItemListModel(content: json["content"]);
}
