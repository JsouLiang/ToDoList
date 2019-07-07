import 'dart:ui';

class Priority {
  
  /// 优先级对应的数值，如 0
  final int value;
  /// 优先级对应的文字描述，如“非常重要”
  final String description;
  /// 优先级对应的颜色，如红色
  final Color color;

  const Priority._(this.value, this.description, this.color);

  /// 重载==运算符
  /// 如果两个 Priority 对象的 value 相等，则它们相等；
  /// 如果一个 Priority 对象的 value 和一个整型值相等，则它们相等
  @override
  bool operator ==(other) => other is Priority && other.value == value || other == value;
  
  /// 重载==运算符必须同时重载 hashCode
  @override
  int get hashCode => value;

  /// 判断当前 Priority 对象是否比另一个 Priority 对象更加重要，
  /// 这里的逻辑就是，谁的 value 值更小，谁的优先级就更高
  bool isImporter(Priority other) => other != null && other.value < value;

  /// 支持用整型值创建 Priority 对象
  factory Priority(int priority) => values.firstWhere((e) => e.value == priority, orElse: () => normal);

  /// 下面定义了允许用户使用的4个枚举值
  static const Priority veryImport = Priority._(0, '非常重要', Color(0xFFE53B3B));
  static const Priority import = Priority._(1, '重要', Color(0xFFFF9400));
  static const Priority normal = Priority._(2, '正常', Color(0xFF14D4F4));
  static const Priority notUrgent = Priority._(3, '不紧急', Color(0xFF50D2C2));

  static const List<Priority> values = [
    veryImport,
    import,
    normal,
    notUrgent,
  ];
}
