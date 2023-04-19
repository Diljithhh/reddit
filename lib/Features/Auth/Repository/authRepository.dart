import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/Common/constants/constants.dart';
import 'package:reddit/Common/constants/firebaseConstants.dart';
import 'package:reddit/Common/failures.dart';
import 'package:reddit/Common/typedef.dart';
import 'package:reddit/Models/userModel.dart';
import 'package:reddit/Providers/firebaseProviders.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
//part 'authRepository.g.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(ref.read(authProvider),
      ref.read(firebasefirestoreProvider), ref.read(googleSigninProvider));
});

 
// AuthRepository authRepository(AuthRepositoryRef ref) {
//   return AuthRepository(ref.watch(authProvider),
//       ref.watch(firebasefirestoreProvider), ref.watch(googleSigninProvider));
// }

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  AuthRepository(this._firebaseAuth, this._firestore, this._googleSignIn);

  CollectionReference get _users => _firestore.collection(
      FirebaseConstants.usersCollection); // getter for user collection

  FutureEithertypedef signinWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      late UserModel userModel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: userCredential.user!.displayName ?? 'default_user',
            profilePic: userCredential.user!.photoURL!,
            banner: Constants.bannerDefault,
            uid: userCredential.user!.uid,
            isAuthenticated: true,
            karma: 0,
            awards: []);

        await _users.doc(userCredential.user!.uid).set(userModel.toMap());

        print('new user');
      } else {
        userModel = await getUserdata(userCredential.user!.uid).first;

        print('already user');
      }

      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.toString();
    } catch (e) {
      return left(Failure(e.toString()));
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

  Stream<UserModel> getUserdata(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
