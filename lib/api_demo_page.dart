import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/user_model.dart'; // Pastikan file user_model.dart sudah kamu buat di folder yang sama

class ApiDemoPage extends StatefulWidget {
  const ApiDemoPage({super.key});

  @override
  State<ApiDemoPage> createState() => _ApiDemoPageState();
}

class _ApiDemoPageState extends State<ApiDemoPage> {
  // Fungsi untuk mengambil data dari REST API Reqres.in
  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

    if (response.statusCode == 200) {
      // Jika server mengembalikan respon 200 OK, extract datanya
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> usersJson = responseData['data'];
      
      // Ubah list JSON menjadi List Objek UserModel
      return usersJson.map((json) => UserModel.fromJson(json)).toList();
    } else {
      // Jika gagal, lempar error
      throw Exception('Gagal memuat data pengguna');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'API Demo Pengguna', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003566),
        elevation: 0,
        automaticallyImplyLeading: false, // Menghilangkan tombol back otomatis di navbar utama
      ),
      body: FutureBuilder<List<UserModel>>(
        future: fetchUsers(), // Fungsi API yang dipanggil
        builder: (context, snapshot) {
          // 1. Kondisi saat data sedang loading/diunduh
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF003566)),
            );
          }
          
          // 2. Kondisi jika terjadi error (misal tidak ada internet)
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  'Terjadi kesalahan: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          // 3. Kondisi saat data berhasil didapatkan
          if (snapshot.hasData) {
            final users = snapshot.data!;
            
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF003566).withOpacity(0.1),
                      backgroundImage: NetworkImage(user.avatar), // Gambar avatar dari URL API
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF003566)),
                    ),
                    subtitle: Text(user.email, style: const TextStyle(color: Colors.grey)),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Tidak ada data'));
        },
      ),
    );
  }
}