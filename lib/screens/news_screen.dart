import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  int _catIndex = 0;
  final List<String> _cats = ['Все', 'Тренды', 'Макияж', 'Бренды', 'Советы'];

  final List<Map<String, dynamic>> _news = [
    {'cat': 'Тренды', 'title': 'Стрижки которые покорят этот сезон', 'desc': 'Топ-10 самых модных стрижек по версии ведущих стилистов мира.', 'date': '14 июня', 'read': '3 мин', 'emoji': '✂️', 'bg': Color(0xFFEDE8FC)},
    {'cat': 'Макияж', 'title': 'Летние техники макияжа 2025', 'desc': 'Как создать лёгкий летний образ за 10 минут.', 'date': '12 июня', 'read': '5 мин', 'emoji': '💄', 'bg': Color(0xFFFCE8F0)},
    {'cat': 'Бренды', 'title': 'Новинки ведущих бьюти-брендов', 'desc': 'Что выпустили Chanel, MAC и NYX этим летом.', 'date': '10 июня', 'read': '4 мин', 'emoji': '⭐', 'bg': Color(0xFFE8F5E9)},
    {'cat': 'Советы', 'title': 'Как ухаживать за окрашенными волосами', 'desc': 'Простые правила которые сохранят цвет надолго.', 'date': '8 июня', 'read': '6 мин', 'emoji': '💜', 'bg': Color(0xFFF0F4FF)},
    {'cat': 'Тренды', 'title': 'Пирсинг уха: тренды 2025', 'desc': 'Какие украшения носят модели на мировых показах.', 'date': '6 июня', 'read': '3 мин', 'emoji': '💎', 'bg': Color(0xFFFFF8E1)},
    {'cat': 'Советы', 'title': 'Брови: форма по типу лица', 'desc': 'Подбираем идеальную форму бровей для каждого.', 'date': '4 июня', 'read': '4 мин', 'emoji': '🤩', 'bg': Color(0xFFFCE8F0)},
  ];

  List<Map<String, dynamic>> get _filtered {
    final cat = _cats[_catIndex];
    return _news.where((n) => cat == 'Все' || n['cat'] == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MiraiColors.white,
      body: Column(children: [
        // Header
        Container(
          color: MiraiColors.violetDark,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: 38, height: 38,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.12), borderRadius: BorderRadius.circular(11)),
                  child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20)),
              ),
              const SizedBox(width: 12),
              Text('Новости Beauty', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
            ]),
            const SizedBox(height: 14),
            Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(13), border: Border.all(color: Colors.white.withOpacity(0.15))),
              child: Row(children: [
                const SizedBox(width: 12),
                Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.4), size: 18),
                const SizedBox(width: 8),
                Expanded(child: TextField(
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Поиск статей...', hintStyle: GoogleFonts.inter(fontSize: 14, color: Colors.white.withOpacity(0.3)),
                    border: InputBorder.none, isDense: true, contentPadding: const EdgeInsets.symmetric(vertical: 11)),
                )),
              ]),
            ),
          ]),
        ),
        // Cats
        Container(
          color: MiraiColors.white,
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
          child: SingleChildScrollView(scrollDirection: Axis.horizontal,
            child: Row(children: List.generate(_cats.length, (i) => GestureDetector(
              onTap: () => setState(() => _catIndex = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 6),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: _catIndex == i ? MiraiColors.violetLight : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(_cats[i], style: GoogleFonts.inter(
                  fontSize: 13, fontWeight: _catIndex == i ? FontWeight.w600 : FontWeight.w400,
                  color: _catIndex == i ? MiraiColors.violet : MiraiColors.textMuted,
                )),
              ),
            ))),
          ),
        ),
        const Divider(height: 1, color: MiraiColors.border),
        // News list
        Expanded(child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _filtered.length,
          itemBuilder: (_, i) {
            final n = _filtered[i];
            return GestureDetector(
              onTap: () => _openArticle(context, n),
              child: Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(width: 64, height: 64,
                    decoration: BoxDecoration(color: n['bg'] as Color, borderRadius: BorderRadius.circular(14)),
                    child: Center(child: Text(n['emoji'] as String, style: const TextStyle(fontSize: 28)))),
                  const SizedBox(width: 12),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(6)),
                      child: Text((n['cat'] as String).toUpperCase(), style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: MiraiColors.violet))),
                    const SizedBox(height: 5),
                    Text(n['title'] as String, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: MiraiColors.textPrimary, height: 1.4)),
                    const SizedBox(height: 5),
                    Text('${n['date']} · ${n['read']} чтения', style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.textMuted)),
                  ])),
                ]),
              ),
            );
          },
        )),
      ]),
    );
  }

  void _openArticle(BuildContext context, Map<String, dynamic> n) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => _ArticleScreen(article: n)));
  }
}

class _ArticleScreen extends StatelessWidget {
  final Map<String, dynamic> article;
  const _ArticleScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MiraiColors.white,
      body: Column(children: [
        Container(height: 200, color: article['bg'] as Color,
          child: Stack(children: [
            Center(child: Text(article['emoji'] as String, style: const TextStyle(fontSize: 72))),
            Positioned(top: MediaQuery.of(context).padding.top + 10, left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: 38, height: 38,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.85), borderRadius: BorderRadius.circular(11)),
                  child: const Icon(Icons.arrow_back_rounded, color: MiraiColors.textPrimary, size: 20)),
              )),
          ]),
        ),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(8)),
            child: Text((article['cat'] as String).toUpperCase(), style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: MiraiColors.violet))),
          const SizedBox(height: 10),
          Text(article['title'] as String, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, color: MiraiColors.textPrimary, height: 1.3)),
          const SizedBox(height: 8),
          Text('${article['date']} · ${article['read']} чтения', style: GoogleFonts.inter(fontSize: 13, color: MiraiColors.textMuted)),
          const SizedBox(height: 20),
          Text(
            '${article['desc']}\n\nЭто одна из самых обсуждаемых тем в beauty-индустрии прямо сейчас. Ведущие стилисты мира делятся своими секретами и советами.\n\nГлавное — найти свой уникальный стиль и не бояться экспериментировать. Приложение Mirai поможет тебе примерить любой образ до реального изменения внешности.\n\nПопробуй прямо сейчас — создай 3D-модель и подбери идеальный образ!',
            style: GoogleFonts.inter(fontSize: 15, color: MiraiColors.textSecondary, height: 1.7),
          ),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.auto_fix_high_rounded, size: 18),
            label: const Text('Примерить образ'),
            style: ElevatedButton.styleFrom(backgroundColor: MiraiColors.violet, foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
          )),
        ]))),
      ]),
    );
  }
}
