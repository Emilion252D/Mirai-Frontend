import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';
import '../widgets/mirai_bottom_nav.dart';
import '../widgets/mirai_drawer.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  int _period = 0;
  final List<String> _periods = ['День', 'Неделя', 'Месяц'];

  final List<List<Map<String, dynamic>>> _data = [
    [
      {'name': 'Platinum Balayage', 'likes': '2.4K', 'views': '18K', 'emoji': '👑', 'bg': Color(0xFFEDE8FC)},
      {'name': 'Rose Pixie Cut', 'likes': '1.8K', 'views': '12K', 'emoji': '🌸', 'bg': Color(0xFFFCE8F0)},
      {'name': 'Vintage Bob', 'likes': '1.2K', 'views': '9K', 'emoji': '✨', 'bg': Color(0xFFE8F5E9)},
      {'name': 'Golden Waves', 'likes': '980', 'views': '7K', 'emoji': '💫', 'bg': Color(0xFFFFF8E1)},
      {'name': 'Dark Pixie', 'likes': '870', 'views': '6K', 'emoji': '🖤', 'bg': Color(0xFFF5F5F5)},
    ],
    [
      {'name': 'French Lob', 'likes': '8.2K', 'views': '64K', 'emoji': '🇫🇷', 'bg': Color(0xFFEDE8FC)},
      {'name': 'Balayage Curls', 'likes': '7.1K', 'views': '55K', 'emoji': '🌊', 'bg': Color(0xFFE8F5E9)},
      {'name': 'Sleek Bun', 'likes': '5.9K', 'views': '42K', 'emoji': '🎀', 'bg': Color(0xFFFCE8F0)},
      {'name': 'Textured Shag', 'likes': '4.8K', 'views': '38K', 'emoji': '💜', 'bg': Color(0xFFF0F4FF)},
      {'name': 'Ash Blonde Bob', 'likes': '4.2K', 'views': '31K', 'emoji': '🌙', 'bg': Color(0xFFFFF8E1)},
    ],
    [
      {'name': 'Butterfly Cut', 'likes': '32K', 'views': '210K', 'emoji': '🦋', 'bg': Color(0xFFEDE8FC)},
      {'name': 'Wolf Cut', 'likes': '28K', 'views': '185K', 'emoji': '🐺', 'bg': Color(0xFFF5F5F5)},
      {'name': 'Curtain Bangs', 'likes': '24K', 'views': '160K', 'emoji': '🌟', 'bg': Color(0xFFFFF8E1)},
      {'name': 'Octopus Cut', 'likes': '19K', 'views': '140K', 'emoji': '🐙', 'bg': Color(0xFFE8F5E9)},
      {'name': 'Bixie Cut', 'likes': '15K', 'views': '120K', 'emoji': '💎', 'bg': Color(0xFFFCE8F0)},
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final items = _data[_period];
    return Scaffold(
      backgroundColor: MiraiColors.bg,
      drawer: const MiraiDrawer(),
      body: Builder(builder: (context) => SafeArea(child: Column(children: [
        // Header
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight,
              colors: [Color(0xFF7C5CD4), MiraiColors.violet, Color(0xFF4A2EA8)]),
          ),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Container(width: 38, height: 38,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(11)),
                  child: const Icon(Icons.menu_rounded, color: Colors.white, size: 20)),
              ),
              const SizedBox(width: 12),
              Text('Рейтинг образов', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
            ]),
            const SizedBox(height: 16),
            Row(children: List.generate(_periods.length, (i) => GestureDetector(
              onTap: () => setState(() => _period = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _period == i ? Colors.white : Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(_periods[i], style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: FontWeight.w500,
                  color: _period == i ? MiraiColors.violet : Colors.white,
                )),
              ),
            ))),
          ]),
        ),
        // List
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (_, i) {
            final item = items[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: MiraiColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: MiraiColors.border, width: 0.5),
              ),
              child: Row(children: [
                // Rank
                SizedBox(width: 28, child: Text('${i + 1}',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600,
                    color: i < 3 ? MiraiColors.violet : MiraiColors.textMuted))),
                // Thumb
                Container(width: 52, height: 52, decoration: BoxDecoration(color: item['bg'] as Color, borderRadius: BorderRadius.circular(14)),
                  child: Center(child: Text(item['emoji'] as String, style: const TextStyle(fontSize: 24)))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(item['name'] as String, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: MiraiColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('♥ ${item['likes']}  👁 ${item['views']}', style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.textMuted)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(10)),
                  child: Text('Примерить', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: MiraiColors.violet)),
                ),
              ]),
            );
          },
        )),
      ]))),
      bottomNavigationBar: MiraiBottomNav(
        currentIndex: 3,
        onTap: (i) { if (i != 3) Navigator.pop(context); },
      ),
    );
  }
}
