import 'package:intl/intl.dart';

List<String> timeFormatter(DateTime date) {
  String shortTime = "", longTime = "";

  Duration diffT = DateTime.now().difference(date);

  if (diffT.inDays <= 0) {
    if (diffT.inHours <= 0) {
      if (diffT.inMinutes <= 0) {
        if (diffT.inSeconds <= 0) {
          shortTime = "now";
        } else {
          shortTime = "${diffT.inSeconds}s";
        }
      } else {
        shortTime = "${diffT.inMinutes}m";
      }
    } else {
      shortTime = "${diffT.inHours}h";
    }
  } else if (diffT.inDays < 7) {
    shortTime = "${diffT.inDays}d";
  } else if (diffT.inDays < 365) {
    shortTime = "${diffT.inDays ~/ 7}w";
  } else {
    shortTime = "${diffT.inDays ~/ 365}y";
  }

  longTime = DateFormat('h:mm:a , d MMMM yyyy').format(date);

  return [shortTime, longTime];
}
