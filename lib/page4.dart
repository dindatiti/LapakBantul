import 'package:flutter/material.dart';
import 'page5.dart';

class Page4 extends StatefulWidget {
  const Page4({super.key});

  @override
  State<Page4> createState() => _Page4State();
}

class _Page4State extends State<Page4> {
  final TextEditingController nopController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A3E78)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PBB',
          style: TextStyle(
            color: Color(0xFF1A3E78),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),

            TextField(
              controller: nopController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Masukan NOP...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              // ✅ FIX: kirim NOP ke Page5
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Page5(nop: value),
                    ),
                  );
                }
              },
            ),

            const Spacer(),

            Column(
              children: const [
                Icon(Icons.find_in_page_rounded,
                    size: 100, color: Colors.grey),
                SizedBox(height: 16),
                Text('Masukan NOP untuk melihat'),
                Text('rincian pajak.',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}