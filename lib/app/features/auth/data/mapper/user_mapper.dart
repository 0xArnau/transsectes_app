import 'package:firebase_auth/firebase_auth.dart';
import 'package:transsectes_app/app/features/auth/domain/entities/user_entity.dart';

/// A utility class to map Firebase [User] to [UserEntity].
class UserMapper {
  /// Maps a [User] from FirebaseAuth to a [UserEntity].
  ///
  /// The method takes the [User] object from FirebaseAuth and returns a
  /// corresponding [UserEntity] containing user details such as email, email verification status,
  /// and whether the user is authenticated.
  static UserEntity toUserEntity(User user) {
    return UserEntity(
      email: user.email ?? '',
      isTechnician: false,
      isEmailVerified: user.emailVerified,
      isAuthenticated: user.uid.isNotEmpty,
    );
  }
}
