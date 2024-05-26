import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadMember() {
    return BaseNetwork.get("jkt48_member.json");
  }
}
