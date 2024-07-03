// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class AuthService {
//   static final FirebaseAuth _auth = FirebaseAuth.instance;
//   static final GoogleSignIn _googleSignIn = GoogleSignIn();
//
//   static bool isLoggedIn() {
//     final User? firebaseUser = _auth.currentUser;
//     return firebaseUser != null;
//   }
//
//   static User currentUser() {
//     final User? firebaseUser = _auth.currentUser;
//     return firebaseUser!;
//   }
//
//   static Future<dynamic> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//         await _auth.signInWithCredential(credential);
//       }
//     } on Exception catch (e) {
//       print('exception->$e');
//     }
//   }
//
//   static Future<bool> signOutFromGoogle() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       return true;
//     } on Exception catch (_) {
//       return false;
//     }
//   }
// }