import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/mirai_theme.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});
  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  bool _yearly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MiraiColors.bg,
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF7C5CD4), MiraiColors.violet, Color(0xFF4A2EA8)])),
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 14, left: 16, right: 16, bottom: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Container(width: 38, height: 38, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(11)),
                  child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20))),
              const SizedBox(width: 12),
              Text('Подписки', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white)),
            ]),
            const SizedBox(height: 16),
            Text('Выберите свой план', style: GoogleFonts.inter(fontSize: 15, color: Colors.white.withOpacity(0.7))),
            const SizedBox(height: 14),
            // Toggle yearly/monthly
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(24)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                _ToggleBtn('Ежемесячно', !_yearly, () => setState(() => _yearly = false)),
                _ToggleBtn('Ежегодно  −20%', _yearly, () => setState(() => _yearly = true)),
              ]),
            ),
          ]),
        ),
        Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(children: [
          // Free plan
          _PlanCard(
            name: 'Бесплатно',
            price: '₸0',
            period: '/ навсегда',
            isPremium: false,
            isCurrent: true,
            features: const [
              _Feature('Базовое сканирование', true),
              _Feature('3 сохранённых дизайна', true),
              _Feature('Базовый каталог', true),
              _Feature('AI-рекомендации', false),
              _Feature('Экспорт в HD', false),
              _Feature('Приоритетная поддержка', false),
            ],
            onTap: () {},
          ),
          const SizedBox(height: 14),
          // Premium plan
          _PlanCard(
            name: 'Premium',
            price: _yearly ? '₸1 990' : '₸2 990',
            period: _yearly ? '/ месяц · при оплате за год' : '/ месяц',
            isPremium: true,
            isCurrent: false,
            features: const [
              _Feature('Безлимитные дизайны', true),
              _Feature('AI-рекомендации по лицу', true),
              _Feature('Экспорт в HD', true),
              _Feature('Полный каталог', true),
              _Feature('Сравнение образов', true),
              _Feature('Приоритетная поддержка', true),
            ],
            onTap: () => _showPayment(context),
          ),
          const SizedBox(height: 20),
          Text('Отменить подписку можно в любое время', style: GoogleFonts.inter(fontSize: 13, color: MiraiColors.textMuted)),
        ]))),
      ]),
    );
  }

  void _showPayment(BuildContext context) {
    showModalBottomSheet(context: context, backgroundColor: Colors.transparent, builder: (_) =>
      Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 44, height: 5, margin: const EdgeInsets.only(top: 12, bottom: 20), decoration: BoxDecoration(color: MiraiColors.border, borderRadius: BorderRadius.circular(3))),
          const Icon(Icons.workspace_premium_rounded, color: MiraiColors.violet, size: 48),
          const SizedBox(height: 12),
          Text('Mirai Premium', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600, color: MiraiColors.textPrimary)),
          const SizedBox(height: 8),
          Text('${_yearly ? '₸1 990' : '₸2 990'} / месяц', style: GoogleFonts.inter(fontSize: 16, color: MiraiColors.violet, fontWeight: FontWeight.w500)),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, child: ElevatedButton(
            onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Подписка активирована! 🎉', style: GoogleFonts.inter()), backgroundColor: MiraiColors.violet)); },
            style: ElevatedButton.styleFrom(backgroundColor: MiraiColors.violet, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
            child: Text('Оформить подписку', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500)),
          )),
          const SizedBox(height: 10),
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Отмена', style: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textMuted))),
        ]),
      ),
    );
  }
}

class _ToggleBtn extends StatelessWidget {
  final String label; final bool active; final VoidCallback onTap;
  const _ToggleBtn(this.label, this.active, this.onTap);
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: active ? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: active ? MiraiColors.violet : Colors.white)),
    ),
  );
}

class _Feature {
  final String label; final bool included;
  const _Feature(this.label, this.included);
}

class _PlanCard extends StatelessWidget {
  final String name, price, period; final bool isPremium, isCurrent;
  final List<_Feature> features; final VoidCallback onTap;
  const _PlanCard({required this.name, required this.price, required this.period, required this.isPremium, required this.isCurrent, required this.features, required this.onTap});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(20),
      border: Border.all(color: isPremium ? MiraiColors.violet : MiraiColors.border, width: isPremium ? 2 : 0.5),
      boxShadow: isPremium ? [BoxShadow(color: MiraiColors.violet.withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 4))] : null,
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (isPremium) Container(
        width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(color: MiraiColors.violet, borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
        child: Center(child: Row(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 16),
          const SizedBox(width: 5),
          Text('Mirai Premium', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
        ])),
      ),
      Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: MiraiColors.textPrimary)),
        const SizedBox(height: 4),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(price, style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w600, color: isPremium ? MiraiColors.violet : MiraiColors.textPrimary)),
          const SizedBox(width: 5),
          Padding(padding: const EdgeInsets.only(bottom: 4), child: Text(period, style: GoogleFonts.inter(fontSize: 12, color: MiraiColors.textMuted))),
        ]),
        const SizedBox(height: 14),
        ...features.map((f) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(children: [
            Icon(f.included ? Icons.check_circle_rounded : Icons.cancel_rounded, color: f.included ? MiraiColors.violet : MiraiColors.border, size: 18),
            const SizedBox(width: 9),
            Text(f.label, style: GoogleFonts.inter(fontSize: 13, color: f.included ? MiraiColors.textPrimary : MiraiColors.textMuted)),
          ]),
        )),
        const SizedBox(height: 14),
        SizedBox(width: double.infinity, child: isCurrent
          ? OutlinedButton(onPressed: null,
              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 13), side: const BorderSide(color: MiraiColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: Text('Текущий план', style: GoogleFonts.inter(fontSize: 14, color: MiraiColors.textMuted)))
          : ElevatedButton(onPressed: onTap,
              style: ElevatedButton.styleFrom(backgroundColor: MiraiColors.violet, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 13), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
              child: Text('Перейти на Premium', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500)))),
      ])),
    ]),
  );
}
