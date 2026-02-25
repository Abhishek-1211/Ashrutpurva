import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call(String email, String password, String? phoneNumber) async {
    await repository.register(email, password, phoneNumber);
  }
}
