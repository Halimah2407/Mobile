import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Model data untuk satu paket
class PaketData {
  final IconData icon;
  final String nama;
  final String deskripsi;
  final String harga;
  final String durasi;
  final List<String> fitur;
  final bool rekomendasi;

  const PaketData({
    required this.icon,
    required this.nama,
    required this.deskripsi,
    required this.harga,
    required this.durasi,
    required this.fitur,
    this.rekomendasi = false,
  });
}

// Daftar semua paket yang mau ditampilkan
final List<PaketData> daftarPaket = [
  const PaketData(
    icon: Icons.smartphone,
    nama: 'Paket Basic',
    deskripsi: 'Cocok untuk kebutuhan sederhana dan usaha kecil',
    harga: 'Rp 2.000.000',
    durasi: '/ proyek',
    fitur: ['Desain UI Standar', 'Setup Database', 'Support Email'],
  ),
  const PaketData(
    icon: Icons.laptop_mac,
    nama: 'Paket Profesional',
    deskripsi: 'Solusi lengkap untuk kebutuhan bisnis digital Anda',
    harga: 'Rp 5.000.000',
    durasi: '/ proyek',
    fitur: [
      'Desain UI/UX Khusus',
      'Setup Database',
      'Konsultasi 24/7',
      'Garansi 1 Tahun',
    ],
    rekomendasi: true,
  ),
  const PaketData(
    icon: Icons.dns,
    nama: 'Paket Enterprise',
    deskripsi: 'Untuk skala besar dengan kebutuhan kompleks',
    harga: 'Rp 12.000.000',
    durasi: '/ proyek',
    fitur: [
      'Desain UI/UX Khusus',
      'Setup Database & Server',
      'Konsultasi 24/7',
      'Garansi 2 Tahun',
      'Maintenance Bulanan',
    ],
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiered Pricing Card',
      home: Scaffold(
        backgroundColor: const Color(0xFFEFEFF4),
        appBar: AppBar(
          title: const Text('Pilih Paket Layanan'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // Scroll vertikal, tiap paket = 1 card sendiri, disusun ke bawah
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          itemCount: daftarPaket.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: PricingCard(data: daftarPaket[index]),
            );
          },
        ),
      ),
    );
  }
}

class PricingCard extends StatefulWidget {
  final PaketData data;
  const PricingCard({super.key, required this.data});

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Container(
      // Layer Dasar: full-width, shadow, rounded corner
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      // Bungkus dengan Material + InkWell biar seluruh body card bisa ditekan
      // dengan efek ripple, lalu toggle expand/collapse detail fiturnya
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => setState(() => expanded = !expanded),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Paket
                    Row(
                      children: [
                        Icon(data.icon, size: 40, color: Colors.indigo),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.nama,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                data.deskripsi,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Harga & Durasi
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          data.harga,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          data.durasi,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),

                    // Body detail yang membesar (isinya lebih penuh) saat card ditekan
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 250),
                      crossFadeState: expanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      firstChild: const SizedBox(width: double.infinity),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(),
                            const SizedBox(height: 4),
                            const Text(
                              'Fitur yang didapat:',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 10),
                            for (final f in data.fitur) ...[
                              FiturItem(text: f),
                              const SizedBox(height: 8),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Tombol Call-to-Action
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Pilih Paket',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Badge "Rekomendasi"
              if (data.rekomendasi)
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Rekomendasi',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FiturItem extends StatelessWidget {
  final String text;
  const FiturItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check, size: 18, color: Colors.green),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}