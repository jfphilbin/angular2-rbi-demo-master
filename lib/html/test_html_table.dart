//TODO: add copyright

//Test HTML Table

import "package:contact_list/html/html_table.dart";

String caption = "Test Table";

List<String> headers = ["foo", "bar", "baz"];
List<bool> numeric = [false, true, true];

List<List> rows = [
  ["a", 1, 2.4],
  ["b", 2, 3.5],
  ["c", 3, 4.6]
];

List<String> footers = ["f1", "f2", "f3"];

void main() {
  var t = new HtmlTable(
  //caption: "This is a Caption",
      header: headers,
      numeric: numeric,
      rows: rows,
      footer: footers,
      indent: 0);
  t.sort(0);
  print("Table Output:\n${t.html}");
  t.sort(0);
  print("Table Output:\n${t.html}");
}
