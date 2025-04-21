import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthService {
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Sign in with Google function
  Future<UserCredential?> loginWithGoogle() async{
    try{
     final googleUser =  await _googleSignIn.signIn();
     final googleAuth = await googleUser?.authentication;
     final cred = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken, 
      accessToken: googleAuth?.accessToken);

     return await _auth.signInWithCredential(cred);
    }
    catch(e){
      print("auth page: ${e}");
    }

    return null;
  }

  // Sign out with Google function
  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      print("User signed out from Google");
    } catch (e) {
      print("Google sign out error: $e");
    }
  }

  // Sign in Email and Password function
  Future<User?> CreateUserWithEmailAndPassword(String email, String password)async{
    try{
    final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    return cred.user;}
    catch(e){
      print("error: ${e}");
    }
    return null;
  }

  // Log in Email and Password function
  Future<User?> LoginUserWithEmailAndPassword(String email, String password)async{
    try{
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return cred.user;}
    catch(e){
      print("error: ${e}");
    }
    return null;
  }

  // Sign out function
  Future<void> signout() async{
    try{
      await _auth.signOut();
    }
    catch(e){
      print("something went wrong. sign out failed");
    }
  }
}