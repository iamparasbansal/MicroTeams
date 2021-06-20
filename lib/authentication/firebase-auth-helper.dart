import 'package:firebase_auth/firebase_auth.dart';
import 'package:microteams/enums/auth-result-status.dart';
import 'package:microteams/authentication/auth-exception-handler.dart';
import 'package:microteams/utils/variables.dart';

class FirebaseAuthHelper {
  final _auth = FirebaseAuth.instance;
  late AuthResultStatus _status;
  
  //------------------------------------------------------------------------
  // Helper Functions
  //------------------------------------------------------------------------

  Future<AuthResultStatus> createAccount({email, password, name}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password
      );
      if (userCredential.user != null) {
        userCollection.doc(userCredential.user!.uid).set({
          'name': name,
          'email': email,
          'password': password,
          'uid': userCredential.user!.uid,
        });
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @createAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  Future<AuthResultStatus> login({email, password}) async {
    try {
      final userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        _status = AuthResultStatus.successful;
      } else {
        _status = AuthResultStatus.undefined;
      }
    } catch (e) {
      print('Exception @loginAccount: $e');
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
  }

  logout() {
    _auth.signOut();
  }
}
