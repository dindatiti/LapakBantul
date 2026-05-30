import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class ApiDemoPage extends StatefulWidget {
  const ApiDemoPage({super.key});

  @override
  State<ApiDemoPage> createState() => _ApiDemoPageState();
}

class _ApiDemoPageState extends State<ApiDemoPage> {
  
  Future<List<UserModel>> fetchLocalUsers() async {
    await Future.delayed(const Duration(seconds: 1));

    final String dummyJsonResponse = '''
    {
      "data": [
        {"id": 1, "email": "george.bluth@reqres.in", "first_name": "George", "last_name": "Bluth", "avatar": "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150"},
        {"id": 2, "email": "janet.weaver@reqres.in", "first_name": "Janet", "last_name": "Weaver", "avatar": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150"},
        {"id": 3, "email": "emma.wong@reqres.in", "first_name": "Emma", "last_name": "Wong", "avatar": "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150"},
        {"id": 4, "email": "eve.holt@reqres.in", "first_name": "Eve", "last_name": "Holt", "avatar": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150"},
        {"id": 5, "email": "charles.morris@reqres.in", "first_name": "Charles", "last_name": "Morris", "avatar": "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150"},
        {"id": 6, "email": "tracey.ramos@reqres.in", "first_name": "Tracey", "last_name": "Ramos", "avatar": "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150"}
      ]
    }
    ''';

    final Map<String, dynamic> responseData = json.decode(dummyJsonResponse);
    final List<dynamic> usersJson = responseData['data'];
    return usersJson.map((json) => UserModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      appBar: AppBar(
        title: const Text(
          'API Demo Pengguna', 
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF003566),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List<UserModel>>(
        future: fetchLocalUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF003566)),
            );
          }
          
          if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            );
          }

          if (snapshot.hasData) {
            final users = snapshot.data!;
            
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    leading: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(user.avatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      '${user.firstName} ${user.lastName}',
                      style: const TextStyle(
                        fontSize: 18, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF003566),
                      ),
                    ),
                    
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        user.email,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
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