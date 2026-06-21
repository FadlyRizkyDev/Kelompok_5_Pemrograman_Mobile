// home_page.dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // --- DATA CONTOH (nanti diganti API) ---
  final List<Map<String, dynamic>> resepPopuler = const [
    {'nama': 'Nasi Goreng', 'emoji': '🍚', 'waktu': '20 mnt', 'rating': 4.8},
    {'nama': 'Sate Ayam', 'emoji': '🍢', 'waktu': '30 mnt', 'rating': 4.7},
    {'nama': 'Rendang', 'emoji': '🥘', 'waktu': '180 mnt', 'rating': 4.9},
    {'nama': 'Gado-Gado', 'emoji': '🥗', 'waktu': '25 mnt', 'rating': 4.6},
  ];

  final List<String> daftarKategori = [
    '🍜 Mie', '🍛 Nasi', '🥘 Kuah', '🥗 Sayur', '🍢 Sate', '🍰 Kue'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ----- APP BAR (Header) -----
      appBar: AppBar(
        title: const Text('Resep Masakan Indonesia'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF97316), // Warna oranye khas makanan
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Nanti dipindah ke halaman pencarian oleh teman lain
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🔍 Cari resep favoritmu!')),
              );
            },
          ),
        ],
      ),

      // ----- BODY (isi halaman) -----
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            // 1. BANNER REKOMENDASI
            _buildBanner(),

            const SizedBox(height: 20),

            // 2. MENU AKSES CEPAT (4 tombol)
            _buildAksesCepat(),

            const SizedBox(height: 24),

            // 3. JUDUL KATEGORI + TOMBOL "Lihat Semua"
            _buildSectionTitle('🍽️ Kategori', 'Lihat Semua'),
            const SizedBox(height: 12),
            _buildDaftarKategori(),

            const SizedBox(height: 24),

            // 4. JUDUL RESEP POPULER + TOMBOL "Lihat Semua"
            _buildSectionTitle('🔥 Resep Populer', 'Lihat Semua'),
            const SizedBox(height: 12),
            _buildGridResep(),

            const SizedBox(height: 24),
          ],
        ),
      ),

      // ----- BOTTOM NAVIGATION (bawah) -----
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF97316),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Jelajahi'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        // Saat ini Beranda yang dipilih (index 0)
        currentIndex: 0,
        onTap: (index) {
          // Nanti diisi navigasi ke halaman lain
        },
      ),
    );
  }

  // ----- WIDGET BANNER -----
  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF97316), Color(0xFFEA580C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.restaurant, color: Colors.white, size: 24),
              SizedBox(width: 8),
              Text('Hari Ini Mau Masak Apa?',
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Rekomendasi: Nasi Goreng Spesial',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('15 menit · Mudah · 2 porsi',
              style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: () {
                // Nanti arahkan ke halaman detail resep
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFF97316),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text('Mulai Masak', fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // ----- WIDGET AKSES CEPAT (4 IKON) -----
  Widget _buildAksesCepat() {
    final entries = [
      {'icon': Icons.restaurant_menu, 'label': 'Semua Resep'},
      {'icon': Icons.local_fire_department, 'label': 'Populer'},
      {'icon': Icons.timer, 'label': 'Cepat Masak'},
      {'icon': Icons.favorite, 'label': 'Favorit'},
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: entries.map((e) {
        return Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: const Color(0xFFFFEDD5),
              child: Icon(e['icon'] as IconData,
                  color: const Color(0xFFF97316), size: 28),
            ),
            const SizedBox(height: 6),
            Text(e['label'] as String,
                style: const TextStyle(fontSize: 12)),
          ],
        );
      }).toList(),
    );
  }

  // ----- WIDGET DAFTAR KATEGORI (scroll horizontal) -----
  Widget _buildDaftarKategori() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: daftarKategori.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFEDD5),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Center(
              child: Text(daftarKategori[index],
                  style: const TextStyle(
                      color: Color(0xFFF97316),
                      fontWeight: FontWeight.w500)),
            ),
          );
        },
      ),
    );
  }

  // ----- WIDGET GRID RESEP POPULER (2 kolom) -----
  Widget _buildGridResep() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // biar nggak scroll sendiri
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: resepPopuler.length,
      itemBuilder: (context, index) {
        final resep = resepPopuler[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian gambar (pakai emoji sementara)
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEDD5),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Text(resep['emoji'] as String,
                      style: const TextStyle(fontSize: 48)),
                ),
              ),
              // Bagian teks
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(resep['nama'] as String,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.access_time,
                            size: 14, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(resep['waktu'] as String,
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                        const Spacer(),
                        const Icon(Icons.star,
                            size: 14, color: Colors.amber),
                        const SizedBox(width: 2),
                        Text(resep['rating'].toString(),
                            style: const TextStyle(
                                fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ----- WIDGET PEMBANTU UNTUK JUDUL SECTION -----
  Widget _buildSectionTitle(String title, String seeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(seeAll,
            style: const TextStyle(
                fontSize: 13, color: Color(0xFFF97316))),
      ],
    );
  }
}
