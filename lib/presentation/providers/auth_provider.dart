import 'package:flutter/foundation.dart';
import 'package:your_app/data/repositories/user_repository.dart';
import 'package:your_app/models/user.dart';

class AuthProvider with ChangeNotifier {
  final UserRepository userRepository;
  User? _currentUser;

  AuthProvider({required this.userRepository});

  User? get currentUser => _currentUser;

  Future<void> signIn(String email, String password) async {
    await userRepository.signIn(email, password);
    notifyListeners();
  }

  Future<void> signOut() async {
    await userRepository.signOut();
    _currentUser = null;
    notifyListeners();
  }
}
