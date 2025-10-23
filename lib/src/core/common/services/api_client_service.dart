class ApiClientService {
  const ApiClientService();
  Future<void> post(String url, dynamic body) async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }

  Future<List<dynamic>> get(String url) async {
    await Future.delayed(Duration(seconds: 2));
    return [];
  }
}
