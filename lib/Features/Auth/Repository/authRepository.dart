import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/Common/constants/constants.dart';
import 'package:reddit/Common/constants/firebaseConstants.dart';
import 'package:reddit/Models/userModel.dart';
import 'package:reddit/Providers/firebaseProviders.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ref.read(authProvider),
      ref.read(firebasefirestoreProvider), ref.read(googleSigninProvider));
});

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  AuthRepository(this._firebaseAuth, this._firestore, this._googleSignIn);

  CollectionReference get _users => _firestore.collection(
      FirebaseConstants.usersCollection); // getter for user collection

  void signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

          if(userCredential.additionalUserInfo!.isNewUser){


  UserModel userModel = UserModel(
          name: userCredential.user!.displayName ?? 'default_user',
          profilePic: userCredential.user!.photoURL!,
          banner: Constants.bannerDefault,
          uid: userCredential.user!.uid,
          isAuthenticated: true,
          karma: 0,
          awards: []);

     await _users.doc(userModel.uid).set(userModel.toMap());
          }else{


            
          }

    
    } catch (e) {
      print(e.toString());
    }
  }

  void signOut() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
