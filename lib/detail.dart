import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert' as convert;
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_invoice_app/models/product.dart';

var f = NumberFormat('#,###.00', 'en_US');

TextEditingController txt;

class DetailsPage extends HookWidget {
  const DetailsPage({this.id});

  final String id;

  build(context) {
    final _products = useState(<Product>[]);

    _getData() async {
      print("ID: " + this.id);

      var url = Uri.https('nanoapi.nanosoft.co.za', '/product/${this.id}');

      var response = await http.get(url, headers: {"x-api-key": "123987"});

      if (response.statusCode == 200) {
        print('L ${response.body.toString()}');

        Iterable jsonResponse = convert.jsonDecode(response.body);

        var products =
            jsonResponse.map((item) => Product.fromJson(item)).toList();
        _products.value = products;

        // print(_products.value[0].name);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

    _buildBody() {
      // print('I: ${_products.value[0].name}');

      // txt = TextEditingController(text: '${_products.value[0].name}');

      return Column(children: [
        TextField(
          // controller: txt,
          decoration: InputDecoration(
              hintText: "e.g Nokia",
              labelText: "Name",
              labelStyle: TextStyle(fontSize: 24, color: Colors.black)),
        ),
        TextField(
          decoration: InputDecoration(
              hintText: "e.g Nokia",
              labelText: "Name",
              labelStyle: TextStyle(fontSize: 24, color: Colors.black)),
        ),
        TextField(
          decoration: InputDecoration(
              hintText: "e.g Nokia",
              labelText: "Name",
              labelStyle: TextStyle(fontSize: 24, color: Colors.black)),
        )
      ]);
    }

    useEffect(() {
      _getData();
      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: _buildBody(),
    );
  }
}
