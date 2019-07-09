import 'package:todo_list/app/data/json.dart';
import 'package:todo_list/app/utils/utils.dart';
import 'package:uuid/uuid.dart';

// 定义地点
class Location extends JSONEncodable<Location> {
  // 纬度
  double latitude;
  // 经度
  double longitude;
  // 地点描述
  String description;

  // 默认的构造器
  Location(this.longitude, this.latitude, [this.description]);

  // 命名构造器，用于构造只有描述信息的 Location 对象
  Location.fromDescription(this.description)
      : latitude = null,
        longitude = null;

  @override
  String toString() {
    return "($longitude, $latitude)";
  }

  @override
  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "description": description,
      };
}

class TodoTask extends JSONEncodable {
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

  TodoTask(
      {this.id,
      this.title = "",
      this.description = "",
      this.fromTime,
      this.toTime,
      this.location,
      this.priority = 0, // 优先级越小优先级越高
      this.notifyTime = const Duration(),
      this.finished = false,
      this.import = false}) {
    // 确保必须有 id，没有就生成一个
    if (id == null) {
      id = generateNewId();
    }
    // 如果开始时间为空，则设置为当前时间
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
    return DateTimeFormatter.formatChineseDate(fromTime);
  }

  String getToTimeStr() {
    return DateTimeFormatter.formatChineseDate(toTime);
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'fromTime': DateTimeFormatter.formatChineseDate(fromTime),
        'toTime': DateTimeFormatter.formatChineseDate(toTime),
        'location': "",
        'priority': priority,
        'finished': finished
      };
}
