import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';
import '../screens/history_screen.dart';
import '../screens/news_screen.dart';
import '../screens/rating_screen.dart';
import '../screens/catalog_screen.dart';
import '../screens/subscriptions_screen.dart';
import '../screens/settings_screen.dart';

class MiraiDrawer extends StatelessWidget {
  const MiraiDrawer({super.key});

  void _go(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MiraiColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(28), bottomRight: Radius.circular(28)),
      ),
      child: SafeArea(child: Column(children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          decoration: const BoxDecoration(color: MiraiColors.white, border: Border(bottom: BorderSide(color: MiraiColors.violetLight, width: 1.5))),
          child: Row(children: [
            Container(width: 54, height: 54, decoration: const BoxDecoration(color: MiraiColors.violet, shape: BoxShape.circle),
              child: Center(child: Text('АС', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Алина Смирнова', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: MiraiColors.textPrimary)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(10)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.workspace_premium_rounded, size: 13, color: MiraiColors.violet),
                  const SizedBox(width: 4),
                  Text('Mirai Premium', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: MiraiColors.violet)),
                ]),
              ),
            ])),
          ]),
        ),
        Expanded(child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          children: [
            _Item(Icons.history_rounded, 'История', MiraiColors.violetLight, MiraiColors.violet, onTap: () => _go(context, const HistoryScreen())),
            _Item(Icons.newspaper_rounded, 'Новости', MiraiColors.violetLight, MiraiColors.violet, badge: '3', onTap: () => _go(context, const NewsScreen())),
            _Item(Icons.emoji_events_rounded, 'Рейтинг', const Color(0xFFE1F5EE), MiraiColors.green, onTap: () => _go(context, const RatingScreen())),
            _Item(Icons.grid_view_rounded, 'Каталог', MiraiColors.violetLight, MiraiColors.violet, onTap: () => _go(context, const CatalogScreen())),
            _Item(Icons.workspace_premium_rounded, 'Подписки', const Color(0xFFFAEEDA), const Color(0xFF854F0B), onTap: () => _go(context, const SubscriptionsScreen())),
            _Item(Icons.settings_rounded, 'Настройки', MiraiColors.violetLight, MiraiColors.violet, onTap: () => _go(context, const SettingsScreen())),
            _Item(Icons.help_outline_rounded, 'Техподдержка', const Color(0xFFFBEAF0), const Color(0xFF993556), onTap: () { Navigator.pop(context); _showSupport(context); }),
            _Item(Icons.info_outline_rounded, 'О нас', const Color(0xFFE1F5EE), MiraiColors.green, onTap: () { Navigator.pop(context); _showAbout(context); }),
          ],
        )),
        Padding(padding: const EdgeInsets.all(16),
          child: Text('Mirai v1.0.0', style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.textMuted))),
      ])),
    );
  }

  void _showSupport(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Column(children: [
          Container(width: 44, height: 5, margin: const EdgeInsets.only(top: 12, bottom: 20), decoration: BoxDecoration(color: MiraiColors.border, borderRadius: BorderRadius.circular(3))),
          Text('Техподдержка', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text('Мы всегда готовы помочь', style: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textMuted)),
          const SizedBox(height: 20),
          ...[('Как создать 3D-модель?','Нажми кнопку + на главном экране'),('Как отменить подписку?','Настройки → Подписки → Отменить'),('Как удалить данные?','Настройки → Управление данными')].map((f) =>
            Container(margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(color: MiraiColors.bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: MiraiColors.border, width: 0.5)),
              child: ListTile(
                leading: const Icon(Icons.help_outline_rounded, color: Color(0xFF9D7FE8)),
                title: Text(f.$1, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)),
                subtitle: Text(f.$2, style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.textMuted)),
                trailing: const Icon(Icons.chevron_right_rounded, color: MiraiColors.textMuted, size: 18)))),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: _ContactBtn('✉️', 'Email')),
            const SizedBox(width: 10),
            Expanded(child: _ContactBtn('💬', 'Telegram')),
          ]),
        ]),
      ));
  }

  void _showAbout(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
        child: Column(children: [
          Container(width: double.infinity, height: 160,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF7C5CD4), MiraiColors.violet, Color(0xFF4A2EA8)]),
              borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 30)),
              const SizedBox(height: 10),
              Text('Mirai', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white)),
              Text('v1.0.0 · beauty-tech', style: GoogleFonts.inter(fontSize: 13, color: Colors.white.withOpacity(0.6))),
            ])),
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(20), child: Column(children: [
            Container(padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: MiraiColors.violetLight, borderRadius: BorderRadius.circular(16), border: Border.all(color: MiraiColors.violetMid, width: 0.5)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('НАША МИССИЯ', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: MiraiColors.violet, letterSpacing: 0.8)),
                const SizedBox(height: 8),
                Text('Mirai помогает безопасно экспериментировать с внешностью — увидь результат до реального изменения прически или стиля.',
                  style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF4A3A7A), height: 1.7)),
              ])),
            const SizedBox(height: 14),
            Row(children: [
              Expanded(child: _StatCard('50K+', 'Пользователей')),
              const SizedBox(width: 10),
              Expanded(child: _StatCard('200+', 'Стилей')),
              const SizedBox(width: 10),
              Expanded(child: _StatCard('4.9 ★', 'Рейтинг')),
            ]),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.mail_outline_rounded, size: 18),
              label: const Text('Связаться с командой'),
              style: ElevatedButton.styleFrom(backgroundColor: MiraiColors.violet, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
          ]))),
        ])));
  }
}

class _Item extends StatelessWidget {
  final IconData icon; final String label; final Color ibg, ic; final String? badge; final VoidCallback onTap;
  const _Item(this.icon, this.label, this.ibg, this.ic, {this.badge, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(onTap: onTap,
    child: Container(margin: const EdgeInsets.only(bottom: 3), padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: Row(children: [
        Container(width: 36, height: 36, decoration: BoxDecoration(color: ibg, borderRadius: BorderRadius.circular(11)), child: Icon(icon, color: ic, size: 19)),
        const SizedBox(width: 13),
        Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 14, color: const Color(0xFF4A3A6A)))),
        if (badge != null)
          Container(width: 22, height: 22, decoration: const BoxDecoration(color: MiraiColors.violet, shape: BoxShape.circle),
            child: Center(child: Text(badge!, style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white))))
        else
          const Icon(Icons.chevron_right_rounded, size: 16, color: MiraiColors.textMuted),
      ])));
}

class _StatCard extends StatelessWidget {
  final String v, l; const _StatCard(this.v, this.l);
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(color: MiraiColors.bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: MiraiColors.border, width: 0.5)),
    child: Column(children: [
      Text(v, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: MiraiColors.violet)),
      const SizedBox(height: 3),
      Text(l, style: GoogleFonts.inter(fontSize: 11, color: MiraiColors.textMuted), textAlign: TextAlign.center),
    ]));
}

class _ContactBtn extends StatelessWidget {
  final String icon, label; const _ContactBtn(this.icon, this.label);
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(color: MiraiColors.bg, borderRadius: BorderRadius.circular(14), border: Border.all(color: MiraiColors.border, width: 0.5)),
    child: Column(children: [
      Text(icon, style: const TextStyle(fontSize: 26)),
      const SizedBox(height: 4),
      Text(label, style: GoogleFonts.inter(fontSize: 13, color: MiraiColors.textMuted)),
    ]));
}
