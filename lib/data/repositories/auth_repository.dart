import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';

class AuthStore {
  final _googleSignIn = GoogleSignIn.standard(scopes: [DriveApi.driveScope]);

  bool _isLoggedIn = false;
  Map<String, String> _authHeaders = {};

  bool get isLoggedIn => _isLoggedIn;
  Map<String, String> get authHeaders => _authHeaders;

  Future<void> setup() async {
    _isLoggedIn = await _googleSignIn.isSignedIn();
    if (_isLoggedIn) {
      await _googleSignIn.signInSilently();
      _authHeaders = await _googleSignIn.currentUser!.authHeaders;
    }
  }

  Future<void> login() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      print("User account $account");
      await setup();
    } catch (error) {}
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    _authHeaders = {};
    _isLoggedIn = false;
  }
}
