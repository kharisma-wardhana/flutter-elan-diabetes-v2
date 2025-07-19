class AntropometriEntity {
  final double height;
  final double weight;
  final double stomach;
  final double hand;
  final double result;
  final String status;
  final String? activity;

  const AntropometriEntity({
    required this.height,
    required this.weight,
    required this.stomach,
    required this.hand,
    required this.result,
    required this.status,
    this.activity,
  });
}
