import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

class AuthRepository {
  final _googleSignIn = GoogleSignIn.standard(scopes: [DriveApi.driveScope]);

  bool _isLoggedIn = false;
  Map<String, String> _authHeaders = {};

  get isLoggedIn => _isLoggedIn;
  get authHeaders => _authHeaders;

  Future<void> login() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        _authHeaders = await account.authHeaders;
        _isLoggedIn = await _googleSignIn.isSignedIn();

        print("User account $account");
      }
    } catch (error) {}
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    _authHeaders = {};
    _isLoggedIn = false;
  }
}
