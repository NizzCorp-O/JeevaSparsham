import 'package:flutter_test/flutter_test.dart';
import 'package:hello_pratice/features/auth/infrastructure/auth_repository_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:hello_pratice/features/auth/domain/repositories/i_auth_repository.dart';


void main() {
  group('AuthBloc login test', () {
    late IAuthRepository mockAuthRepository;

    setUp(() {
      mockAuthRepository = AuthRepositoryImpl();
    });

    test('login success returns userId', () async {
      // Arrange: mock login to return a userId
      when(mockAuthRepository.login(email: 'a@gmail.com', password: '123445'))
          .thenAnswer((_) async => 'userId123');

      // Act: call login
      final result = await mockAuthRepository.login(email: 'a@gmail.com', password: '123445');

      // Assert: result is not null (login successful)
      expect(result, isNotNull);
      expect(result, 'userId123');
      verify(mockAuthRepository.login(email: 'a@gmail.com', password: '123445')).called(1);
    });

    test('login failure returns null', () async {
      // Arrange: mock login to return null (failure)
      when(mockAuthRepository.login(email: 'a@gmail.com', password: 'wrongpass'))
          .thenAnswer((_) async => null);

      // Act: call login
      final result = await mockAuthRepository.login(email: 'a@gmail.com', password: 'wrongpass');

      // Assert: result is null (login failed)
      expect(result, isNull);
      verify(mockAuthRepository.login(email: 'a@gmail.com', password: 'wrongpass')).called(1);
    });
  });
}
