import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _aiRecommendations = true;
  String _quality = 'Высокое';
  String _lang = 'Русский';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MiraiColors.bg,
      body: Column(children: [
        Container(
          color: MiraiColors.violet,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 24),
          child: Row(children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(width: 38, height: 38,
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(11)),
                child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20)),
            ),
            const SizedBox(width: 12),
            Text('Настройки', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
          ]),
        ),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
          // Profile card
          GestureDetector(
            onTap: () => _showProfileEdit(context),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(color: MiraiColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: MiraiColors.border, width: 0.5)),
              child: Row(children: [
                Container(width: 52, height: 52, decoration: const BoxDecoration(color: MiraiColors.violet, shape: BoxShape.circle),
                  child: Center(child: Text('АС', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)))),
                const SizedBox(width: 13),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Алина Смирнова', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: MiraiColors.textPrimary)),
                  Text('alina@mail.ru', style: GoogleFonts.inter(fontSize: 13, color: MiraiColors.textMuted)),
                ])),
                const Icon(Icons.chevron_right_rounded, color: MiraiColors.textMuted),
              ]),
            ),
          ),
          const SizedBox(height: 16),
          // Interface
          _GroupTitle('Интерфейс'),
          _SettingsGroup(children: [
            _SwitchTile(icon: Icons.dark_mode_rounded, iconBg: MiraiColors.violetLight, iconColor: MiraiColors.violet, label: 'Тёмная тема', value: _darkMode, onChanged: (v) => setState(() => _darkMode = v)),
            _SwitchTile(icon: Icons.notifications_rounded, iconBg: const Color(0xFFFAEEDA), iconColor: const Color(0xFF854F0B), label: 'Уведомления', value: _notifications, onChanged: (v) => setState(() => _notifications = v)),
            _SwitchTile(icon: Icons.auto_awesome_rounded, iconBg: MiraiColors.violetLight, iconColor: MiraiColors.violet, label: 'AI-рекомендации', value: _aiRecommendations, onChanged: (v) => setState(() => _aiRecommendations = v)),
            _ArrowTile(icon: Icons.threed_rotation_rounded, iconBg: MiraiColors.violetLight, iconColor: MiraiColors.violet, label: 'Качество 3D-модели', value: _quality,
              onTap: () => _showPicker(context, 'Качество 3D-модели', ['Низкое', 'Среднее', 'Высокое', 'Ультра'], _quality, (v) => setState(() => _quality = v))),
          ]),
          const SizedBox(height: 12),
          // Language
          _GroupTitle('Язык и регион'),
          _SettingsGroup(children: [
            _ArrowTile(icon: Icons.language_rounded, iconBg: const Color(0xFFE1F5EE), iconColor: MiraiColors.green, label: 'Язык интерфейса', value: _lang,
              onTap: () => _showPicker(context, 'Язык', ['Русский', 'Қазақша', 'English', 'Deutsch', 'Türkçe'], _lang, (v) => setState(() => _lang = v))),
          ]),
          const SizedBox(height: 12),
          // Data
          _GroupTitle('Управление данными'),
          _SettingsGroup(children: [
            _ArrowTile(icon: Icons.storage_rounded, iconBg: MiraiColors.violetLight, iconColor: MiraiColors.violet, label: 'Управление данными', onTap: () {}),
            _ArrowTile(icon: Icons.shield_rounded, iconBg: MiraiColors.violetLight, iconColor: MiraiColors.violet, label: 'Конфиденциальность', onTap: () {}),
            _ArrowTile(icon: Icons.cleaning_services_rounded, iconBg: const Color(0xFFFAEEDA), iconColor: const Color(0xFF854F0B), label: 'Очистить кэш', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Кэш очищен', style: GoogleFonts.inter()), backgroundColor: MiraiColors.violetDark));
            }),
          ]),
          const SizedBox(height: 12),
          // Danger zone
          _SettingsGroup(children: [
            _ArrowTile(icon: Icons.delete_forever_rounded, iconBg: const Color(0xFFFCEBEB), iconColor: MiraiColors.red, label: 'Удалить аккаунт', labelColor: MiraiColors.red,
              onTap: () => _confirmDelete(context)),
          ]),
          const SizedBox(height: 20),
          Text('Mirai v1.0.0', style: GoogleFonts.inter(fontSize: 13, color: MiraiColors.textMuted)),
          const SizedBox(height: 20),
        ]))),
      ]),
    );
  }

  void _showPicker(BuildContext context, String title, List<String> options, String current, ValueChanged<String> onSelect) {
    showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) =>
      Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 44, height: 5, margin: const EdgeInsets.only(top: 12, bottom: 16), decoration: BoxDecoration(color: MiraiColors.border, borderRadius: BorderRadius.circular(3))),
          Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600, color: MiraiColors.textPrimary)),
          const SizedBox(height: 12),
          ...options.map((o) => GestureDetector(
            onTap: () { onSelect(o); Navigator.pop(context); },
            child: Container(
              width: double.infinity, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(color: o == current ? MiraiColors.violetLight : Colors.transparent),
              child: Row(children: [
                Text(o, style: GoogleFonts.inter(fontSize: 15, fontWeight: o == current ? FontWeight.w500 : FontWeight.w400, color: o == current ? MiraiColors.violet : MiraiColors.textPrimary)),
                const Spacer(),
                if (o == current) const Icon(Icons.check_rounded, color: MiraiColors.violet, size: 20),
              ]),
            ),
          )),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  void _showProfileEdit(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) =>
      Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 44, height: 5, margin: const EdgeInsets.only(top: 12, bottom: 20), decoration: BoxDecoration(color: MiraiColors.border, borderRadius: BorderRadius.circular(3))),
            Text('Редактировать профиль', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            _Field(label: 'Имя', initial: 'Алина Смирнова'),
            const SizedBox(height: 12),
            _Field(label: 'E-mail', initial: 'alina@mail.ru'),
            const SizedBox(height: 12),
            _Field(label: 'Возраст', initial: '25'),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(backgroundColor: MiraiColors.violet, foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: Text('Сохранить', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500)),
            )),
          ]),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Удалить аккаунт?', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
      content: Text('Все данные и 3D-модели будут удалены безвозвратно.', style: GoogleFonts.inter(color: MiraiColors.textSecondary)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Отмена', style: GoogleFonts.inter(color: MiraiColors.textMuted))),
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Удалить', style: GoogleFonts.inter(color: MiraiColors.red, fontWeight: FontWeight.w600))),
      ],
    ));
  }
}

class _Field extends StatelessWidget {
  final String label, initial;
  const _Field({required this.label, required this.initial});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.textMuted, fontWeight: FontWeight.w500)),
    const SizedBox(height: 5),
    TextFormField(initialValue: initial,
      style: GoogleFonts.inter(fontSize: 15, color: MiraiColors.textPrimary),
      decoration: InputDecoration(
        filled: true, fillColor: MiraiColors.bg,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: MiraiColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: MiraiColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: MiraiColors.violet, width: 1.5)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      )),
  ]);
}

class _GroupTitle extends StatelessWidget {
  final String title;
  const _GroupTitle(this.title);
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(left: 4, bottom: 8),
    child: Text(title, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: MiraiColors.textMuted, letterSpacing: 0.3)),
  );
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(color: MiraiColors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: MiraiColors.border, width: 0.5)),
    child: Column(children: List.generate(children.length, (i) => Column(children: [
      children[i],
      if (i < children.length - 1) const Divider(height: 1, indent: 52, color: MiraiColors.border),
    ]))),
  );
}

class _SwitchTile extends StatelessWidget {
  final IconData icon; final Color iconBg, iconColor; final String label; final bool value; final ValueChanged<bool> onChanged;
  const _SwitchTile({required this.icon, required this.iconBg, required this.iconColor, required this.label, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    child: Row(children: [
      Container(width: 34, height: 34, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: iconColor, size: 18)),
      const SizedBox(width: 12),
      Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textPrimary))),
      Switch(value: value, onChanged: onChanged, activeColor: MiraiColors.violet, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
    ]),
  );
}

class _ArrowTile extends StatelessWidget {
  final IconData icon; final Color iconBg, iconColor; final String label; final String? value; final Color? labelColor; final VoidCallback onTap;
  const _ArrowTile({required this.icon, required this.iconBg, required this.iconColor, required this.label, this.value, this.labelColor, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(children: [
        Container(width: 34, height: 34, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: iconColor, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: GoogleFonts.inter(fontSize: 14, color: labelColor ?? MiraiColors.textPrimary))),
        if (value != null) Text(value!, style: GoogleFonts.inter(fontSize: 13, color: MiraiColors.textMuted)),
        const SizedBox(width: 4),
        Icon(Icons.chevron_right_rounded, color: MiraiColors.textMuted, size: 18),
      ]),
    ),
  );
}
