class GetDevicesParams {
  final bool all;
  final int? userId;
  final int? id;
  final String? uniqueId;

  GetDevicesParams({this.all = false, this.userId, this.id, this.uniqueId});
}
