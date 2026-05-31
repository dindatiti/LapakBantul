import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  // Instance untuk FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fungsi untuk Sign In menggunakan Google
  Future<User?> signInWithGoogle() async {
    try {
      final googleSignIn = GoogleSignIn();
      
      // =======================================================================
      // SENJATA UTAMA: Menggunakan disconnect() untuk membersihkan total token.
      // Ditambah try-catch kecil agar jika sesi memang sudah bersih, tidak error.
      // =======================================================================
      try {
        await googleSignIn.disconnect();
      } catch (_) {
        // Abaikan error jika ternyata sesi dari awal memang sudah bersih
      }

      // Membuka jendela login Google yang DIJAMIN memunculkan pilihan akun
      final googleUser = await googleSignIn.signIn();
      
      // Jika user membatalkan proses login
      if (googleUser == null) return null;

      // 2. Dapatkan detail verifikasi dari akun Google
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken == null) {
        print('Google sign-in gagal: idToken null');
        return null;
      }

      // 3. Buat kredensial baru untuk Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // 4. Masuk ke Firebase menggunakan kredensial tersebut
      final userCredential = await _auth.signInWithCredential(credential);

      // Mengembalikan data user yang berhasil login
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Firebase auth error: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('Sign-in error: $e');
      return null;
    }
  }

  // Fungsi untuk Sign Out / Log Out
  Future<void> signOut() async {
    try {
      await GoogleSignIn().disconnect(); // Ubah juga di sini agar bersih total saat logout biasa
      await _auth.signOut();
    } catch (e) {
      print('Error saat sign out: $e');
    }
  }
}