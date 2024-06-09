abstract class RemoteLocationDataProvider {
  Future<dynamic> locationSearch({
    required String location,
    int limit = 5,
  });
}
