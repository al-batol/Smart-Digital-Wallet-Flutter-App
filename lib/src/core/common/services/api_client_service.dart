class ApiClientService {
  const ApiClientService();
  Future<void> post(String url, dynamic body) async {
    await Future.delayed(Duration(seconds: 2));
    return;
  }
}
