
import 'package:flutter/material.dart';
import 'package:ghino_gas_flutter/utilis/utilis.dart';

class SearchPeople extends SearchDelegate {
  List<String> peoples = <String>[
    "Quân",
    "Linh",
    "Khánh",
    "Ngọc",
    "Ánh",
    "Hoa",
    "Quỳnh"
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.home));
  }

  @override
  Widget buildResults(BuildContext context) {
    List results = [];

    for (var item in peoples) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        title: Text("${results[index]}"),
        onTap: () {
          Utils.toastMessage("${results[index]}");
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List suggestions = [];

    for (var item in peoples) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        suggestions.add(item);
      }
    }
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) => ListTile(
              title: Text("${suggestions[index]}"),
              onTap: () {
                Utils.toastMessage("${suggestions[index]}");
              },
            ));
  }
}
