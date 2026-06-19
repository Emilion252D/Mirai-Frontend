import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> _items = [
    {'name': 'Образ «Весна»', 'date': '14 июня 2025', 'emoji': '💁', 'bg': Color(0xFFEDE8FC)},
    {'name': 'Короткое каре', 'date': '10 июня 2025', 'emoji': '👩‍🦱', 'bg': Color(0xFFFCE8F0)},
    {'name': 'Вечерний образ', 'date': '5 июня 2025', 'emoji': '🌸', 'bg': Color(0xFFE8F5E9)},
    {'name': 'Боб с укладкой', 'date': '1 июня 2025', 'emoji': '✨', 'bg': Color(0xFFFFF8E1)},
    {'name': 'Летний образ', 'date': '28 мая 2025', 'emoji': '☀️', 'bg': Color(0xFFF0F4FF)},
  ];

  void _delete(int i) {
    setState(() => _items.removeAt(i));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Дизайн удалён', style: GoogleFonts.inter()), backgroundColor: MiraiColors.violetDark,
        action: SnackBarAction(label: 'Отменить', textColor: const Color(0xFFB09EE0), onPressed: () {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MiraiColors.bg,
      body: Column(children: [
        // Header
        Container(
          color: MiraiColors.violet,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 20),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(width: 38, height: 38,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(11)),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20)),
            ),
            const SizedBox(width: 12),
            Text('История дизайнов', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
          ]),
        ),
        // List
        Expanded(child: _items.isEmpty
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.history_rounded, size: 64, color: MiraiColors.border),
              const SizedBox(height: 16),
              Text('История пуста', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: MiraiColors.textMuted)),
              const SizedBox(height: 8),
              Text('Создай первый дизайн!', style: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textMuted)),
            ]))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _items.length,
              itemBuilder: (_, i) {
                final item = _items[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: MiraiColors.white, borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: MiraiColors.border, width: 0.5),
                  ),
                  child: Row(children: [
                    Container(width: 54, height: 54,
                      decoration: BoxDecoration(color: item['bg'] as Color, borderRadius: BorderRadius.circular(14)),
                      child: Center(child: Text(item['emoji'] as String, style: const TextStyle(fontSize: 26)))),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(item['name'] as String, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: MiraiColors.textPrimary)),
                      const SizedBox(height: 4),
                      Text(item['date'] as String, style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.textMuted)),
                    ])),
                    Column(children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(8)),
                          child: Text('Открыть', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: MiraiColors.violet))),
                      ),
                      const SizedBox(height: 5),
                      GestureDetector(
                        onTap: () => _delete(i),
                        child: Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(color: const Color(0xFFFCEBEB), borderRadius: BorderRadius.circular(8)),
                          child: Text('Удалить', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: MiraiColors.red))),
                      ),
                    ]),
                  ]),
                );
              },
            )),
      ]),
    );
  }
}
