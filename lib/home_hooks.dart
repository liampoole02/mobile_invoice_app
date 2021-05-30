import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_invoice_app/detail.dart';
import 'package:mobile_invoice_app/models/product.dart';

var f = NumberFormat('#,###.00', 'en_US');
var d = DateFormat('dd-MMM-yyyy');

class MyHomePage extends HookWidget {
  _buildLoadingIndicator() {
    return Center(
      child: Text("Loading..."),
    );
  }

  build(context) {
    final _products = useState(<Product>[]);
    final _isLoading = useState(true);

    _getData() async {
      var url = Uri.https('nanoapi.nanosoft.co.za', '/product');

      var response = await http.get(url, headers: {"x-api-key": "123987"});
      if (response.statusCode == 200) {
        Iterable jsonResponse = convert.jsonDecode(response.body);
        var products =
            jsonResponse.map((item) => Product.fromJson(item)).toList();
        print('Product result: ${products.length}');
        _products.value = products;
        _isLoading.value = false;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

    _buildBody() {
      if (_isLoading.value) return _buildLoadingIndicator();
      return ListView.builder(
        itemCount: _products.value.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_products.value[index].name}'),
            subtitle: Text('R ${f.format(_products.value[index].unitPrice)}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailsPage(id: _products.value[index].sId),
                ),
              );
            },
          );
        },
      );
    }

    useEffect(() {
      _getData();
      return;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text("Products Hooks"),
      ),
      body: _buildBody(),
    );
  }
}
