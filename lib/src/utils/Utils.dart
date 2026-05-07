


class Utils {



  static double degreesToRadians(double degrees) {
    return degrees * (3.141592653589793 / 180);
  }


  static List<Match> regTokenMatchLists( String str, String reg_expression ) {

    RegExp regExp = RegExp(reg_expression, multiLine: true);
    Iterable<Match> matches = regExp.allMatches(str);
    List<Match> list = [];

    for (Match m in matches) {
      list.add(m);
    }
    return list;
  }

  static List<List<String>> regTokenStringLists( String str, String reg_expression ) {

    RegExp regExp = RegExp(reg_expression, multiLine: true);
    Iterable<Match> matches = regExp.allMatches(str);
    List<List<String>> list = [];

    for (Match m in matches) {
      List<String> strings = [];
      for (int i = 1; i <= m.groupCount; i++) {
        strings.add(m.group(i)!);
      }
      list.add(strings);
    }
    return list;
  }

}