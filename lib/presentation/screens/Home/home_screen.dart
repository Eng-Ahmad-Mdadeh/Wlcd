import 'package:flutter/material.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SubjectCategory? _selectedCategory;
  Tutor? _selectedTutor;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    final categories = _categories;
    final tutors = _selectedCategory == null
        ? <Tutor>[]
        : _tutors.where((tutor) => tutor.category == _selectedCategory!.title).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7FB),
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: _selectedTutor != null
                ? _TutorDetailsView(
                    key: ValueKey(_selectedTutor!.name),
                    tutor: _selectedTutor!,
                    selectedDate: _selectedDate,
                    onBack: () => setState(() {
                      _selectedTutor = null;
                      _selectedDate = null;
                    }),
                    onDateSelected: (date) => setState(() => _selectedDate = date),
                  )
                : _selectedCategory != null
                    ? _TutorsView(
                        key: ValueKey(_selectedCategory!.title),
                        category: _selectedCategory!,
                        tutors: tutors,
                        onBack: () => setState(() => _selectedCategory = null),
                        onTutorSelected: (tutor) => setState(() => _selectedTutor = tutor),
                      )
                    : _CategoriesView(
                        key: const ValueKey('categories'),
                        categories: categories,
                        onCategorySelected: (category) => setState(() => _selectedCategory = category),
                      ),
          ),
        ),
      ),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView({super.key, required this.categories, required this.onCategorySelected});

  final List<SubjectCategory> categories;
  final ValueChanged<SubjectCategory> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _HeroHeader(
            title: 'إحجز مدرسك الخصوصي بثقة',
            subtitle: 'اختر المادة، قارن بين أفضل المدرسين، ثم احجز موعداً مناسباً خلال دقائق.',
            chipText: 'جلسات مباشرة • مواعيد مرنة',
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          sliver: SliverList.list(
            children: [
              const _SectionTitle(title: 'ما المادة التي تريد تقويتها؟', subtitle: 'تصنيفات مختارة بناءً على طلب الطلاب'),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: .92,
                ),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return _CategoryCard(category: category, onTap: () => onCategorySelected(category));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TutorsView extends StatelessWidget {
  const _TutorsView({super.key, required this.category, required this.tutors, required this.onBack, required this.onTutorSelected});

  final SubjectCategory category;
  final List<Tutor> tutors;
  final VoidCallback onBack;
  final ValueChanged<Tutor> onTutorSelected;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _PageHeader(
            title: 'مدرسو ${category.title}',
            subtitle: '${tutors.length} مدرسين متاحين هذا الأسبوع',
            icon: category.icon,
            color: category.color,
            onBack: onBack,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
          sliver: SliverList.separated(
            itemCount: tutors.length,
            separatorBuilder: (_, __) => const SizedBox(height: 14),
            itemBuilder: (context, index) => _TutorCard(tutor: tutors[index], onTap: () => onTutorSelected(tutors[index])),
          ),
        ),
      ],
    );
  }
}

class _TutorDetailsView extends StatelessWidget {
  const _TutorDetailsView({super.key, required this.tutor, required this.selectedDate, required this.onBack, required this.onDateSelected});

  final Tutor tutor;
  final DateTime? selectedDate;
  final VoidCallback onBack;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final days = _nextSevenDays;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: _TutorProfileHeader(tutor: tutor, onBack: onBack)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          sliver: SliverList.list(
            children: [
              _InfoCard(tutor: tutor),
              const SizedBox(height: 18),
              const _SectionTitle(title: 'اختر تاريخ الحجز', subtitle: 'الأيام الخضراء متاحة، والرمادية محجوزة بالكامل'),
              const SizedBox(height: 14),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: days.map((date) {
                  final isBooked = tutor.bookedDays.contains(date.day);
                  final isSelected = selectedDate?.day == date.day;
                  return _DateChip(date: date, isBooked: isBooked, isSelected: isSelected, onTap: isBooked ? null : () => onDateSelected(date));
                }).toList(),
              ),
              const SizedBox(height: 22),
              _BookingButton(enabled: selectedDate != null, tutorName: tutor.name),
            ],
          ),
        ),
      ],
    );
  }
}

class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.title, required this.subtitle, required this.chipText});
  final String title, subtitle, chipText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF3654D4)], begin: Alignment.topRight, end: Alignment.bottomLeft),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [BoxShadow(color: Color(0x331F275D), blurRadius: 28, offset: Offset(0, 16))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _SoftChip(text: chipText),
        const SizedBox(height: 22),
        Text(title, style: _textStyle(28, FontWeight.w800, AppColors.white, height: 1.25)),
        const SizedBox(height: 12),
        Text(subtitle, style: _textStyle(14, FontWeight.w400, const Color(0xFFE6EAFF), height: 1.7)),
        const SizedBox(height: 22),
        Row(children: const [
          _Metric(value: '+48', label: 'مدرس خبير'),
          SizedBox(width: 12),
          _Metric(value: '4.9', label: 'تقييم الطلاب'),
        ]),
      ]),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, required this.subtitle, required this.icon, required this.color, required this.onBack});
  final String title, subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Row(children: [
          _BackButton(onTap: onBack),
          const SizedBox(width: 12),
          Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: color.withOpacity(.13), borderRadius: BorderRadius.circular(18)), child: Icon(icon, color: color)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: _textStyle(24, FontWeight.w800, AppColors.text)), const SizedBox(height: 6), Text(subtitle, style: _textStyle(13, FontWeight.w500, AppColors.muted))])),
        ]),
      );
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.category, required this.onTap});
  final SubjectCategory category;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(26),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(26), boxShadow: const [BoxShadow(color: Color(0x0F1F275D), blurRadius: 22, offset: Offset(0, 12))]),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: category.color.withOpacity(.12), borderRadius: BorderRadius.circular(20)), child: Icon(category.icon, color: category.color, size: 30)),
            const Spacer(),
            Text(category.title, style: _textStyle(19, FontWeight.w800, AppColors.text)),
            const SizedBox(height: 8),
            Text(category.description, style: _textStyle(12, FontWeight.w500, AppColors.muted, height: 1.5)),
          ]),
        ),
      );
}

class _TutorCard extends StatelessWidget {
  const _TutorCard({required this.tutor, required this.onTap});
  final Tutor tutor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(28), border: Border.all(color: const Color(0xFFECEEF6))),
          child: Row(children: [
            _Avatar(initials: tutor.initials, color: tutor.color, size: 74),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Expanded(child: Text(tutor.name, style: _textStyle(18, FontWeight.w800, AppColors.text))), const Icon(Icons.star_rounded, color: Color(0xFFFFB800), size: 19), Text(' ${tutor.rating}', style: _textStyle(13, FontWeight.w700, AppColors.text))]),
              const SizedBox(height: 7),
              Text(tutor.description, maxLines: 2, overflow: TextOverflow.ellipsis, style: _textStyle(12.5, FontWeight.w500, AppColors.muted, height: 1.55)),
              const SizedBox(height: 10),
              Row(children: [_MiniPill(text: tutor.category), const SizedBox(width: 8), _MiniPill(text: tutor.experience)]),
            ])),
          ]),
        ),
      );
}

class _TutorProfileHeader extends StatelessWidget {
  const _TutorProfileHeader({required this.tutor, required this.onBack});
  final Tutor tutor;
  final VoidCallback onBack;
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(gradient: LinearGradient(colors: [tutor.color, AppColors.primary]), borderRadius: BorderRadius.circular(32)),
        child: Column(children: [
          Align(alignment: Alignment.centerRight, child: _BackButton(onTap: onBack, light: true)),
          _Avatar(initials: tutor.initials, color: AppColors.white, size: 96, textColor: tutor.color),
          const SizedBox(height: 14),
          Text(tutor.name, style: _textStyle(24, FontWeight.w800, AppColors.white)),
          const SizedBox(height: 8),
          Text('${tutor.category} • ${tutor.experience}', style: _textStyle(14, FontWeight.w500, const Color(0xFFEAF0FF))),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_Metric(value: tutor.rating.toString(), label: 'التقييم'), const SizedBox(width: 10), _Metric(value: tutor.sessions, label: 'جلسة')]),
        ]),
      );
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.tutor});
  final Tutor tutor;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(26), border: Border.all(color: const Color(0xFFECEEF6))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('نبذة عن المدرس', style: _textStyle(18, FontWeight.w800, AppColors.text)),
          const SizedBox(height: 10),
          Text(tutor.fullBio, style: _textStyle(13.5, FontWeight.w500, AppColors.muted, height: 1.75)),
          const SizedBox(height: 14),
          Row(children: [Expanded(child: _DetailTile(icon: Icons.video_call_rounded, title: 'نوع الدرس', value: 'أونلاين مباشر')), Expanded(child: _DetailTile(icon: Icons.payments_rounded, title: 'السعر', value: tutor.price))]),
        ]),
      );
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.date, required this.isBooked, required this.isSelected, required this.onTap});
  final DateTime date;
  final bool isBooked, isSelected;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          width: 84,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: isBooked ? const Color(0xFFE9ECF3) : isSelected ? AppColors.primary : const Color(0xFFEAF8F1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isSelected ? AppColors.primary : Colors.transparent),
          ),
          child: Column(children: [
            Text(_weekday(date.weekday), style: _textStyle(12, FontWeight.w700, isSelected ? AppColors.white : isBooked ? AppColors.navInactive : AppColors.darkGreen)),
            const SizedBox(height: 6),
            Text('${date.day}', style: _textStyle(22, FontWeight.w900, isSelected ? AppColors.white : isBooked ? AppColors.navInactive : AppColors.text)),
            const SizedBox(height: 4),
            Text(isBooked ? 'محجوز' : 'متاح', style: _textStyle(11, FontWeight.w700, isSelected ? AppColors.white : isBooked ? AppColors.navInactive : AppColors.darkGreen)),
          ]),
        ),
      );
}

class _BookingButton extends StatelessWidget {
  const _BookingButton({required this.enabled, required this.tutorName});
  final bool enabled;
  final String tutorName;
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: enabled ? AppColors.primary : AppColors.navInactive, foregroundColor: AppColors.white, minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), elevation: 0),
        onPressed: enabled ? () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('تم إرسال طلب الحجز مع $tutorName'))) : null,
        child: Text(enabled ? 'تأكيد الحجز' : 'اختر تاريخاً متاحاً أولاً', style: _textStyle(16, FontWeight.w800, AppColors.white)),
      );
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap, this.light = false});
  final VoidCallback onTap;
  final bool light;
  @override
  Widget build(BuildContext context) => Material(color: light ? AppColors.white.withOpacity(.16) : AppColors.white, shape: const CircleBorder(), child: IconButton(onPressed: onTap, icon: Icon(Icons.arrow_back_ios_new_rounded, color: light ? AppColors.white : AppColors.primary, size: 18)));
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});
  final String title, subtitle;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: _textStyle(22, FontWeight.w800, AppColors.text)), const SizedBox(height: 6), Text(subtitle, style: _textStyle(13, FontWeight.w500, AppColors.muted))]);
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.initials, required this.color, required this.size, this.textColor = AppColors.white});
  final String initials;
  final Color color, textColor;
  final double size;
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, alignment: Alignment.center, decoration: BoxDecoration(color: color, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 18, offset: Offset(0, 10))]), child: Text(initials, style: _textStyle(size * .28, FontWeight.w900, textColor)));
}

class _Metric extends StatelessWidget { const _Metric({required this.value, required this.label}); final String value, label; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), decoration: BoxDecoration(color: AppColors.white.withOpacity(.14), borderRadius: BorderRadius.circular(16)), child: Column(children: [Text(value, style: _textStyle(18, FontWeight.w900, AppColors.white)), Text(label, style: _textStyle(11, FontWeight.w500, const Color(0xFFEAF0FF)))])); }
class _SoftChip extends StatelessWidget { const _SoftChip({required this.text}); final String text; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: AppColors.white.withOpacity(.14), borderRadius: BorderRadius.circular(999)), child: Text(text, style: _textStyle(12, FontWeight.w700, AppColors.white))); }
class _MiniPill extends StatelessWidget { const _MiniPill({required this.text}); final String text; @override Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFF0F3FF), borderRadius: BorderRadius.circular(999)), child: Text(text, style: _textStyle(11, FontWeight.w700, AppColors.primary))); }
class _DetailTile extends StatelessWidget { const _DetailTile({required this.icon, required this.title, required this.value}); final IconData icon; final String title, value; @override Widget build(BuildContext context) => Row(children: [Icon(icon, color: AppColors.accent), const SizedBox(width: 8), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: _textStyle(11, FontWeight.w600, AppColors.muted)), Text(value, style: _textStyle(13, FontWeight.w800, AppColors.text))]))]); }

TextStyle _textStyle(double size, FontWeight weight, Color color, {double? height}) => TextStyle(fontFamily: AppFontFamily.rubik, fontSize: size, fontWeight: weight, color: color, height: height);
String _weekday(int day) => const ['الإث', 'الثلا', 'الأرب', 'الخمي', 'الجم', 'السب', 'الأحد'][day - 1];
List<DateTime> get _nextSevenDays => List.generate(7, (index) => DateTime.now().add(Duration(days: index + 1)));

class SubjectCategory {
  const SubjectCategory({required this.title, required this.description, required this.icon, required this.color});
  final String title, description;
  final IconData icon;
  final Color color;
}

class Tutor {
  const Tutor({required this.name, required this.initials, required this.category, required this.description, required this.fullBio, required this.experience, required this.rating, required this.sessions, required this.price, required this.color, required this.bookedDays});
  final String name, initials, category, description, fullBio, experience, sessions, price;
  final double rating;
  final Color color;
  final List<int> bookedDays;
}

const _categories = [
  SubjectCategory(title: 'الرياضيات', description: 'جبر، هندسة، تفاضل واختبارات قدرات', icon: Icons.calculate_rounded, color: Color(0xFF2F80ED)),
  SubjectCategory(title: 'الفيزياء', description: 'ميكانيكا، كهرباء، تجارب وحل مسائل', icon: Icons.science_rounded, color: Color(0xFF9B51E0)),
  SubjectCategory(title: 'الكيمياء', description: 'عضوية، تحليلية ومراجعات مكثفة', icon: Icons.biotech_rounded, color: Color(0xFF00A86B)),
  SubjectCategory(title: 'اللغة الإنجليزية', description: 'محادثة، قواعد، كتابة وتحضير اختبارات', icon: Icons.translate_rounded, color: Color(0xFFF2994A)),
];

final _tutors = [
  Tutor(name: 'أ. أحمد العلي', initials: 'أع', category: 'الرياضيات', description: 'متخصص في تبسيط المفاهيم الصعبة بخطط تدريب شخصية.', fullBio: 'مدرس رياضيات بخبرة 9 سنوات في مناهج المرحلة الثانوية والجامعية. يعتمد على تقييم سريع لمستوى الطالب ثم بناء خطة عملية مليئة بالأمثلة والتطبيقات.', experience: '9 سنوات', rating: 4.9, sessions: '+820', price: '85 ر.س', color: const Color(0xFF2F80ED), bookedDays: [DateTime.now().add(const Duration(days: 2)).day, DateTime.now().add(const Duration(days: 5)).day]),
  Tutor(name: 'أ. نورة خالد', initials: 'نخ', category: 'الرياضيات', description: 'تحضير اختبارات القدرات والتحصيلي مع متابعة أسبوعية.', fullBio: 'تقدم جلسات تفاعلية للقدرات والتحصيلي، وتستخدم خرائط ذهنية وتمارين قصيرة لرفع سرعة الحل ودقته.', experience: '7 سنوات', rating: 4.8, sessions: '+610', price: '75 ر.س', color: const Color(0xFF3654D4), bookedDays: [DateTime.now().add(const Duration(days: 1)).day, DateTime.now().add(const Duration(days: 4)).day]),
  Tutor(name: 'د. سامر منصور', initials: 'سم', category: 'الفيزياء', description: 'ربط الفيزياء بالحياة اليومية لتسهيل الفهم والحفظ.', fullBio: 'دكتور في الفيزياء التطبيقية، يساعد الطلاب على فهم القوانين من خلال المحاكاة والرسومات وحل مسائل متدرجة الصعوبة.', experience: '11 سنة', rating: 4.9, sessions: '+940', price: '95 ر.س', color: const Color(0xFF9B51E0), bookedDays: [DateTime.now().add(const Duration(days: 3)).day]),
  Tutor(name: 'م. ليان فهد', initials: 'لف', category: 'الكيمياء', description: 'شرح مبسط للتفاعلات والمعادلات مع ملخصات مرئية.', fullBio: 'مدرسة كيمياء تركز على تحويل النظريات إلى خطوات سهلة، مع أوراق عمل بعد كل حصة وقياس مستمر للتقدم.', experience: '6 سنوات', rating: 4.7, sessions: '+430', price: '70 ر.س', color: const Color(0xFF00A86B), bookedDays: [DateTime.now().add(const Duration(days: 2)).day, DateTime.now().add(const Duration(days: 6)).day]),
  Tutor(name: 'أ. مازن يوسف', initials: 'مي', category: 'اللغة الإنجليزية', description: 'محادثة وقواعد وكتابة أكاديمية بأسلوب عملي.', fullBio: 'مدرس لغة إنجليزية معتمد، يصمم الجلسة حسب هدف الطالب: تحسين المحادثة، تقوية القواعد، أو الاستعداد لاختبارات اللغة.', experience: '8 سنوات', rating: 4.8, sessions: '+700', price: '80 ر.س', color: const Color(0xFFF2994A), bookedDays: [DateTime.now().add(const Duration(days: 1)).day, DateTime.now().add(const Duration(days: 5)).day]),
];
