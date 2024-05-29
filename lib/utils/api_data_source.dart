import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();
  Future<Map<String, dynamic>> loadData() {
    return BaseNetwork.get("jkt48_member.json");
  }

  Future<Map<String, dynamic>> loadEvent() {
    return BaseNetwork.get("jkt48_event.json");
  }
}
