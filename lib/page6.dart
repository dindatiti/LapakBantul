import 'package:flutter/material.dart';

class Page6 extends StatelessWidget {
  final bool isPaid;
  final String year;
  final String address;
  final String name; // 🔥 tambah

  const Page6({
    super.key,
    required this.isPaid,
    required this.year,
    required this.address,
    required this.name, // 🔥 tambah
  });

  @override
  Widget build(BuildContext context) {
    return DetailPajakScreen(
      isPaid: isPaid,
      year: year,
      address: address,
      name: name, // 🔥 kirim
    );
  }
}

class DetailPajakScreen extends StatelessWidget {
  final bool isPaid;
  final String year;
  final String address;
  final String name; // 🔥 tambah

  const DetailPajakScreen({
    super.key,
    required this.isPaid,
    required this.year,
    required this.address,
    required this.name, // 🔥 tambah
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blueGrey),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 pakai year
            Text(
              'SPPT $year',
              style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
            ),
            const SizedBox(height: 8),

            // 🔥 pakai name (tidak hardcode lagi)
            Text(
              name,
              style: const TextStyle(
                color: Color(0xFF1A2E44),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.blueGrey, fontSize: 12),
                children: [
                  const TextSpan(
                    text: 'Alamat Lengkap WP : ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: address,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            DetailItem(
              label: 'Lokasi',
              value: address,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status',
                    style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),

                  StatusBadge(
                    text: isPaid ? 'Sudah Lunas' : 'Belum Lunas',
                  ),

                  const Divider(height: 24, thickness: 0.8),
                ],
              ),
            ),

            const DetailItem(label: 'Denda', value: 'Rp. 0'),
            const DetailItem(label: 'NJOP Bumi', value: 'Rp. 300,000'),
            const DetailItem(label: 'NJOP Bangunan', value: 'Rp. 0'),
            const DetailItem(label: 'Luas Bumi', value: '227m'),
            const DetailItem(
              label: 'Luas Bangunan',
              value: '-',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}

class DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const DetailItem({
    super.key,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.blueGrey, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF1A2E44),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (!isLast) const Divider(height: 24, thickness: 0.8),
      ],
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String text;
  const StatusBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final isLunas = text == 'Sudah Lunas';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isLunas ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}