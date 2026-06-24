import 'package:flutter/material.dart';

class SubjectCategory {
  const SubjectCategory({required this.title, required this.description, required this.icon, required this.color});

  final String title;
  final String description;
  final IconData icon;
  final Color color;
}

class Tutor {
  const Tutor({
    required this.name,
    required this.initials,
    required this.category,
    required this.description,
    required this.fullBio,
    required this.experience,
    required this.rating,
    required this.sessions,
    required this.price,
    required this.color,
    required this.bookedDays,
  });

  final String name;
  final String initials;
  final String category;
  final String description;
  final String fullBio;
  final String experience;
  final double rating;
  final String sessions;
  final String price;
  final Color color;
  final List<int> bookedDays;
}

const privateTutorCategories = [
  SubjectCategory(title: 'الرياضيات', description: 'جبر، هندسة، تفاضل واختبارات قدرات', icon: Icons.calculate_rounded, color: Color(0xFF2F80ED)),
  SubjectCategory(title: 'الفيزياء', description: 'ميكانيكا، كهرباء، تجارب وحل مسائل', icon: Icons.science_rounded, color: Color(0xFF9B51E0)),
  SubjectCategory(title: 'الكيمياء', description: 'عضوية، تحليلية ومراجعات مكثفة', icon: Icons.biotech_rounded, color: Color(0xFF00A86B)),
  SubjectCategory(title: 'اللغة الإنجليزية', description: 'محادثة، قواعد، كتابة وتحضير اختبارات', icon: Icons.translate_rounded, color: Color(0xFFF2994A)),
];

List<Tutor> privateTutors() => [
      Tutor(
        name: 'أ. أحمد العلي',
        initials: 'أع',
        category: 'الرياضيات',
        description: 'متخصص في تبسيط المفاهيم الصعبة بخطط تدريب شخصية.',
        fullBio: 'مدرس رياضيات بخبرة 9 سنوات في مناهج المرحلة الثانوية والجامعية. يعتمد على تقييم سريع لمستوى الطالب ثم بناء خطة عملية مليئة بالأمثلة والتطبيقات.',
        experience: '9 سنوات',
        rating: 4.9,
        sessions: '+820',
        price: '85 ر.س',
        color: const Color(0xFF2F80ED),
        bookedDays: [_dayAfter(2), _dayAfter(5)],
      ),
      Tutor(
        name: 'أ. نورة خالد',
        initials: 'نخ',
        category: 'الرياضيات',
        description: 'تحضير اختبارات القدرات والتحصيلي مع متابعة أسبوعية.',
        fullBio: 'تقدم جلسات تفاعلية للقدرات والتحصيلي، وتستخدم خرائط ذهنية وتمارين قصيرة لرفع سرعة الحل ودقته.',
        experience: '7 سنوات',
        rating: 4.8,
        sessions: '+610',
        price: '75 ر.س',
        color: const Color(0xFF3654D4),
        bookedDays: [_dayAfter(1), _dayAfter(4)],
      ),
      Tutor(
        name: 'د. سامر منصور',
        initials: 'سم',
        category: 'الفيزياء',
        description: 'ربط الفيزياء بالحياة اليومية لتسهيل الفهم والحفظ.',
        fullBio: 'دكتور في الفيزياء التطبيقية، يساعد الطلاب على فهم القوانين من خلال المحاكاة والرسومات وحل مسائل متدرجة الصعوبة.',
        experience: '11 سنة',
        rating: 4.9,
        sessions: '+940',
        price: '95 ر.س',
        color: const Color(0xFF9B51E0),
        bookedDays: [_dayAfter(3)],
      ),
      Tutor(
        name: 'م. ليان فهد',
        initials: 'لف',
        category: 'الكيمياء',
        description: 'شرح مبسط للتفاعلات والمعادلات مع ملخصات مرئية.',
        fullBio: 'مدرسة كيمياء تركز على تحويل النظريات إلى خطوات سهلة، مع أوراق عمل بعد كل حصة وقياس مستمر للتقدم.',
        experience: '6 سنوات',
        rating: 4.7,
        sessions: '+430',
        price: '70 ر.س',
        color: const Color(0xFF00A86B),
        bookedDays: [_dayAfter(2), _dayAfter(6)],
      ),
      Tutor(
        name: 'أ. مازن يوسف',
        initials: 'مي',
        category: 'اللغة الإنجليزية',
        description: 'محادثة وقواعد وكتابة أكاديمية بأسلوب عملي.',
        fullBio: 'مدرس لغة إنجليزية معتمد، يصمم الجلسة حسب هدف الطالب: تحسين المحادثة، تقوية القواعد، أو الاستعداد لاختبارات اللغة.',
        experience: '8 سنوات',
        rating: 4.8,
        sessions: '+700',
        price: '80 ر.س',
        color: const Color(0xFFF2994A),
        bookedDays: [_dayAfter(1), _dayAfter(5)],
      ),
    ];

List<DateTime> nextSevenDays() => List.generate(7, (index) => DateTime.now().add(Duration(days: index + 1)));

int _dayAfter(int days) => DateTime.now().add(Duration(days: days)).day;
