import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';
import '../widgets/mirai_bottom_nav.dart';
import '../widgets/mirai_drawer.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _navIndex = 1;
  int _tabIndex = 0;
  final _searchController = TextEditingController();

  final List<String> _tabs = ['Все', 'Прически', 'Цвет', 'Макияж', 'Украшения', 'Очки', 'Борода'];

  final List<Map<String, dynamic>> _items = [
    {'name': 'Французское каре', 'rating': '4.9', 'views': '12K', 'cat': 'Прически', 'bg': Color(0xFFEDE8FC), 'icon': Icons.content_cut_rounded, 'color': Color(0xFF6C47C4)},
    {'name': 'Вечерний макияж', 'rating': '4.7', 'views': '9K', 'cat': 'Макияж', 'bg': Color(0xFFFCE8F0), 'icon': Icons.face_retouching_natural_rounded, 'color': Color(0xFFD85A80)},
    {'name': 'Золотые серьги', 'rating': '4.8', 'views': '7K', 'cat': 'Украшения', 'bg': Color(0xFFFFF8E1), 'icon': Icons.diamond_rounded, 'color': Color(0xFFE8A020)},
    {'name': 'Авиаторы', 'rating': '4.6', 'views': '5K', 'cat': 'Очки', 'bg': Color(0xFFE8F5E9), 'icon': Icons.visibility_rounded, 'color': Color(0xFF1D9E75)},
    {'name': 'Пикси стрижка', 'rating': '4.8', 'views': '15K', 'cat': 'Прически', 'bg': Color(0xFFEDE8FC), 'icon': Icons.content_cut_rounded, 'color': Color(0xFF6C47C4)},
    {'name': 'Дневной макияж', 'rating': '4.5', 'views': '8K', 'cat': 'Макияж', 'bg': Color(0xFFFCE8F0), 'icon': Icons.face_retouching_natural_rounded, 'color': Color(0xFFD85A80)},
    {'name': 'Волнистое каре', 'rating': '4.7', 'views': '11K', 'cat': 'Прически', 'bg': Color(0xFFEDE8FC), 'icon': Icons.content_cut_rounded, 'color': Color(0xFF6C47C4)},
    {'name': 'Серебряные кольца', 'rating': '4.9', 'views': '6K', 'cat': 'Украшения', 'bg': Color(0xFFF0F4FF), 'icon': Icons.diamond_rounded, 'color': Color(0xFF4A7AE0)},
  ];

  List<Map<String, dynamic>> get _filtered {
    final tab = _tabs[_tabIndex];
    return _items.where((i) {
      final matchTab = tab == 'Все' || i['cat'] == tab;
      final q = _searchController.text.toLowerCase();
      final matchSearch = q.isEmpty || (i['name'] as String).toLowerCase().contains(q);
      return matchTab && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MiraiColors.bg,
      drawer: const MiraiDrawer(),
      body: Builder(builder: (context) => SafeArea(
        child: Column(children: [
          // Header
          Container(
            color: MiraiColors.white,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    width: 38, height: 38,
                    decoration: BoxDecoration(color: MiraiColors.bg, borderRadius: BorderRadius.circular(11)),
                    child: const Icon(Icons.menu_rounded, color: MiraiColors.textPrimary, size: 20),
                  ),
                ),
                const SizedBox(width: 12),
                Text('Каталог', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: MiraiColors.textPrimary)),
                const Spacer(),
                Icon(Icons.favorite_border_rounded, color: MiraiColors.textMuted, size: 22),
              ]),
              const SizedBox(height: 12),
              // Search
              Container(
                decoration: BoxDecoration(color: MiraiColors.bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: MiraiColors.border)),
                child: Row(children: [
                  const SizedBox(width: 12),
                  const Icon(Icons.search_rounded, color: MiraiColors.textMuted, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    style: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Поиск стилей и образов...',
                      hintStyle: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textMuted),
                      border: InputBorder.none, isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  )),
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(9)),
                    child: const Icon(Icons.tune_rounded, color: MiraiColors.violet, size: 18),
                  ),
                ]),
              ),
              const SizedBox(height: 12),
              // Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: List.generate(_tabs.length, (i) => GestureDetector(
                  onTap: () => setState(() => _tabIndex = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: _tabIndex == i ? MiraiColors.violet : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: _tabIndex == i ? MiraiColors.violet : MiraiColors.border),
                    ),
                    child: Text(_tabs[i], style: GoogleFonts.inter(
                      fontSize: 13, fontWeight: FontWeight.w500,
                      color: _tabIndex == i ? Colors.white : MiraiColors.textMuted,
                    )),
                  ),
                ))),
              ),
              const SizedBox(height: 14),
            ]),
          ),
          // Grid
          Expanded(child: _filtered.isEmpty
            ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.search_off_rounded, size: 48, color: MiraiColors.textMuted),
                const SizedBox(height: 12),
                Text('Ничего не найдено', style: GoogleFonts.inter(fontSize: 16, color: MiraiColors.textMuted)),
              ]))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.85),
                itemCount: _filtered.length,
                itemBuilder: (_, i) {
                  final item = _filtered[i];
                  return GestureDetector(
                    onTap: () => _showDetail(context, item),
                    child: Container(
                      decoration: BoxDecoration(
                        color: MiraiColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: MiraiColors.border, width: 0.5),
                      ),
                      child: Column(children: [
                        Expanded(child: Container(
                          decoration: BoxDecoration(
                            color: item['bg'] as Color,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                          ),
                          child: Center(child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 44)),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(item['name'] as String, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: MiraiColors.textPrimary)),
                            const SizedBox(height: 4),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text('★ ${item['rating']}', style: GoogleFonts.inter(fontSize: 11, color: MiraiColors.textMuted)),
                              Text('Примерить', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: MiraiColors.violet)),
                            ]),
                          ]),
                        ),
                      ]),
                    ),
                  );
                },
              )),
        ]),
      )),
      bottomNavigationBar: MiraiBottomNav(
        currentIndex: _navIndex,
        onTap: (i) { if (i != 1) Navigator.pop(context); },
      ),
    );
  }

  void _showDetail(BuildContext context, Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        child: Column(children: [
          Container(width: 44, height: 5, margin: const EdgeInsets.only(top: 12, bottom: 16), decoration: BoxDecoration(color: MiraiColors.border, borderRadius: BorderRadius.circular(3))),
          Container(height: 160, margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(color: item['bg'] as Color, borderRadius: BorderRadius.circular(20)),
            child: Center(child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 72)),
          ),
          Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item['name'] as String, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, color: MiraiColors.textPrimary)),
            const SizedBox(height: 8),
            Row(children: [
              Text('★ ${item['rating']}', style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF9D7FE8))),
              const SizedBox(width: 12),
              Text('👁 ${item['views']} просм.', style: GoogleFonts.inter(fontSize: 13, color: MiraiColors.textMuted)),
              const SizedBox(width: 12),
              Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(8)),
                child: Text(item['cat'] as String, style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.violet))),
            ]),
            const SizedBox(height: 14),
            Text('Классический образ с современными акцентами. Подходит для большинства типов лица. Рекомендован AI-стилистом Mirai.',
              style: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textSecondary, height: 1.6)),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.auto_fix_high_rounded, size: 18),
              label: const Text('Примерить на модели'),
              style: ElevatedButton.styleFrom(backgroundColor: MiraiColors.violet, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            )),
            const SizedBox(height: 10),
            SizedBox(width: double.infinity, child: OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.bookmark_border_rounded, size: 18),
              label: const Text('Сохранить в избранное'),
              style: OutlinedButton.styleFrom(foregroundColor: MiraiColors.violet, side: const BorderSide(color: MiraiColors.violetMid), padding: const EdgeInsets.symmetric(vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
            )),
          ])),
        ]),
      ),
    );
  }
}
