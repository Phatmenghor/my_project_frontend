import 'package:my_project/core/services/api_client.dart';

class TestService {
  final ApiClient apiClient;

  TestService(this.apiClient);

  // Future<List<User>> fetchUsers() async {
  //   try {
  //     final response = await apiClient.get<List<User>>('/users');
  //     return (response.data as List)
  //         .map((userJson) => User.fromJson(userJson))
  //         .toList();
  //   } catch (e) {
  //     // Handle the error
  //     throw Exception('Failed to load users: $e');
  //   }
  // }
}
