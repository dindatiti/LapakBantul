import 'package:flutter/material.dart';
import 'page6.dart'; 

void main() => runApp(const MyApp());

// ================= ROOT APP =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page5(nop: ""),
    );
  }
}

// ================= PAGE 5 =================
class Page5 extends StatelessWidget {
  final String nop;

  const Page5({super.key, required this.nop});

  @override
  Widget build(BuildContext context) {
    return PbbSearchScreen(nop: nop);
  }
}

// ================= SCREEN =================
class PbbSearchScreen extends StatefulWidget {
  final String nop;

  const PbbSearchScreen({super.key, required this.nop});

  @override
  State<PbbSearchScreen> createState() => _PbbSearchScreenState();
}

class _PbbSearchScreenState extends State<PbbSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _allData = [
    {
      "nop": "764177342178410",
      "year": "2021",
      "address": "DS. Ngireng-ireng RT01/RW01",
      "amount": "200.000",
      "isPaid": false,
      "name": "Baek Yi-jin", // 🔥 tambah
    },
    {
      "nop": "764177342178410",
      "year": "2020",
      "address": "DS. Ngireng-ireng RT01/RW01",
      "amount": "376.000",
      "isPaid": true,
      "name": "Cha Sung-hoon", // 🔥 beda
    },
    {
      "nop": "123456789012345",
      "year": "2022",
      "address": "DS. Maju Jaya RT02/RW05",
      "amount": "150.000",
      "isPaid": false,
      "name": "kinaan ozama elfatih", // 🔥 tambah
    },
  ];

  List<Map<String, dynamic>> _foundData = [];

  @override
  void initState() {
    super.initState();

    _searchController.text = widget.nop;
    _runFilter(widget.nop);

    if (widget.nop.isEmpty) {
      _foundData = _allData;
    }
  }

  void _runFilter(String value) {
    setState(() {
      if (value.isEmpty) {
        _foundData = _allData;
      } else {
        final results = _allData.where((data) {
          final nop = data["nop"].toString();
          return nop.contains(value);
        }).toList();

        _foundData = results.isEmpty ? _allData : results;
      }
    });
  }

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
        title: const Text(
          'PBB',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF0D3B66)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                keyboardType: TextInputType.number,
                onChanged: _runFilter,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: "Masukkan NOP",
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: _foundData.length,
                itemBuilder: (context, index) {
                  final item = _foundData[index];

                  return PbbCard(
                    year: item["year"],
                    address: item["address"],
                    amount: item["amount"],
                    isPaid: item["isPaid"],
                    name: item["name"], // 🔥 tambah
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= CARD =================
class PbbCard extends StatelessWidget {
  final String year;
  final String address;
  final String amount;
  final bool isPaid;
  final String name; // 🔥 tambah

  const PbbCard({
    super.key,
    required this.year,
    required this.address,
    required this.amount,
    required this.isPaid,
    required this.name, // 🔥 tambah
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SPPT $year",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(address),
          const SizedBox(height: 8),
          Text("Rp $amount"),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: isPaid ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isPaid ? "Lunas" : "Belum Lunas",
              style: const TextStyle(color: Colors.white),
            ),
          ),

          const Divider(height: 25),

          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Page6(
                    isPaid: isPaid,
                    year: year,
                    address: address,
                    name: name, // 🔥 kirim
                  ),
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Lihat Detail",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 4),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}