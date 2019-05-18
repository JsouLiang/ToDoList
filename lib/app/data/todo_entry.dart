import 'package:intl/intl.dart';
import 'package:todo_list/app/data/json.dart';
import 'package:uuid/uuid.dart';

class Location extends JSONEncodable<Location> {
  double latitude;
  double longitude;
  Location(this.longitude, this.latitude);

  @override
  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

final formatter = DateFormat('MM-dd hh:mm');

class TodoEntry extends JSONEncodable {
  String id;
  String title;
  String description;
  DateTime fromTime;
  DateTime toTime;
  Location location;
  int priority;
  Duration notifyTime;
  bool finished;
  // 星标 任务
  bool import;
  TodoEntry(
      {this.id,
      this.title,
      this.description,
      this.fromTime,
      this.toTime,
      this.location,
      this.priority = 0, // 优先级越小优先级越高
      this.notifyTime = const Duration(),
      this.finished = false,
      this.import = false}) {
    if (id == null) {
      id = generateNewId();
    }
    if (fromTime == null) {
      fromTime = DateTime.now();
    }
    if (toTime == null) {
      toTime = fromTime;
    }
  }

  static Uuid _uuid = Uuid();

  static String generateNewId() => _uuid.v1();

  String getFromTimeStr() {
    return formatter.format(fromTime);
  }

  String getToTimeStr() {
    return formatter.format(toTime);
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'fromTime': fromTime,
        'toTime': toTime,
        'location': location,
        'priority': priority,
        'notifyTime': notifyTime,
      };
}
