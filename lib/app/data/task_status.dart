import 'dart:ui';

class TaskStatus {
  
  /// 完成状态对应的数值，如 0
  final int value;
  /// 完成状态对应的文字描述，如“已完成”
  final String description;
  /// 完成状态对应的颜色，如红色
  final Color color;

  const TaskStatus._(this.value, this.description, this.color);

  /// 重载==运算符
  /// 如果两个 Priority 对象的 value 相等，则它们相等；
  /// 如果一个 Priority 对象的 value 和一个整型值相等，则它们相等
  @override
  bool operator ==(other) => other is TaskStatus && other.value == value || other == value;
  
  /// 重载==运算符必须同时重载 hashCode
  @override
  int get hashCode => value;

  /// 判断当前 Priority 对象是否比另一个 Priority 对象更加重要，
  /// 这里的逻辑就是，谁的 value 值更小，谁的完成状态就更高
  bool isFinished() => this == TaskStatus.finished;

  /// 支持用整型值创建 TaskStatus 对象
  factory TaskStatus(int status) => values.firstWhere((e) => e.value == status, orElse: () => handling);

  /// 下面定义了允许用户使用的4个枚举值
  static const TaskStatus handling = TaskStatus._(0, '处理中', const Color(0xff8c88ff));
  static const TaskStatus finished = TaskStatus._(1, '已完成', const Color(0xff51d2c2));
  static const TaskStatus delay = TaskStatus._(2, '已延期', const Color(0xffffb258));

  static const List<TaskStatus> values = [
    handling,
    finished,
    delay,
  ];
}
