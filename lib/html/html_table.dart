library html_table;

import 'spaces.dart';

class HtmlTable {
  final String caption;
  final List<String> header;
  final List<bool> numeric;
  final List<List> rows;
  final List<String> footer;
  final int indent;
  bool isAscending = true;
  Spaces sp;

  int get length => rows.length;
  int get width => rows[0].length;

  //HtmlTable._(this.caption, this.header, this.numeric, this.rows, this.footer, this.indent);

  HtmlTable({this.caption, this.header, this.numeric, this.rows, this.footer, this.indent}) {
    sp = new Spaces(indent);
  }

  String get html {
    //sp = (indent == null)? "" : "".padRight(indent, " ");
    String s = '$sp<table>\n';
    if (caption != null) s += _caption;
    if (header != null) s += _header;
    if (rows != null) s += _rows;
    if (footer != null) s += _footer;
    s += s = "$sp</table>\n";
    return s;
  }

  String get _caption => '$sp  <caption>$sp$caption</caption>\n';

  //class="mdl-data-table__cell--non-numeric"
  String get _header {
    String s = "$sp  <thead>\n$sp    <tr>\n";
    for(var i = 0; i < header.length; i++) {
      var th = (numeric[i] == true) ? "<th>" : '<th class="mdl-data-table__cell--non-numeric"';
      s += '$sp      $th${header[i]}</th>\n';
    }
    return s += "$sp    </tr>\n$sp  </thead>\n";
  }

  //TODO: add class="mdl-data-table__cell--non-numeric"
  String get _rows {
    String s = "$sp  <tbody>\n";
    for(var i = 0; i < rows.length; i++) {
      List row = rows[i];
      s += "$sp    <tr>\n";
      var isp = "$sp      "; // indent 2 spaces
      for(var j = 0; j < row.length; j++) {
        var td = (numeric[j] == true) ? "<td>" : '<td class="mdl-data-table__cell--non-numeric"';
        s += '$isp$td${row[j]}</td>\n';
      }
      s += "$sp    </tr>\n";
    }
    s += "$sp  </tbody>\n";
    return s;
  }

  //TODO: add class="mdl-data-table__cell--non-numeric"
  String get _footer {
    String s = "$sp  <tfoot>\n$sp    <tr>\n";
    for(var i = 0; i < footer.length; i++) {
      s += '$sp      <th>${footer[i]}</th>\n';
    }
    return s += "$sp    </tr>\n$sp  </tfoot>\n";
  }

  void sort(int column) {
    int ascending(List rowX, List rowY) => rowX[column].compareTo(rowY[column]);
    int descending(List rowX, List rowY) => rowY[column].compareTo(rowX[column]);

    rows.sort((isAscending)? ascending : descending);
    isAscending = (isAscending == true) ? false : true;
  }
}
