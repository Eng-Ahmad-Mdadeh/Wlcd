import 'package:flutter/material.dart';

class TeacherData {
  const TeacherData({
    required this.name,
    required this.specialty,
    required this.bio,
    required this.rating,
    required this.students,
    required this.imageUrl,
    required this.accentColor,
  });

  final String name;
  final String specialty;
  final String bio;
  final double rating;
  final String students;
  final String imageUrl;
  final Color accentColor;
}

const List<TeacherData> teachers = [
  TeacherData(
    name: 'د. سارة العلي',
    specialty: 'استراتيجية الأعمال',
    bio: 'تساعد المتعلمين على بناء خطط نمو عملية وربط المفاهيم النظرية بتحديات السوق اليومية.',
    rating: 4.9,
    students: '2.4k',
    imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=480&q=80',
    accentColor: Color(0xFF6C63FF),
  ),
  TeacherData(
    name: 'م. أحمد منصور',
    specialty: 'تحليل البيانات',
    bio: 'خبير في تحويل البيانات إلى قرارات واضحة من خلال أمثلة تطبيقية ولوحات معلومات تفاعلية.',
    rating: 4.8,
    students: '1.8k',
    imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=480&q=80',
    accentColor: Color(0xFF16A3B8),
  ),
  TeacherData(
    name: 'أ. ليان خالد',
    specialty: 'التسويق الرقمي',
    bio: 'تركز على بناء حملات تسويقية ذكية وتجارب محتوى تزيد التفاعل وتحسن نتائج العلامات التجارية.',
    rating: 4.7,
    students: '3.1k',
    imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=480&q=80',
    accentColor: Color(0xFFF59E0B),
  ),
  TeacherData(
    name: 'د. يوسف ناصر',
    specialty: 'إدارة المشاريع',
    bio: 'يمزج بين الأطر الاحترافية وأدوات المتابعة الحديثة لإدارة فرق العمل وتسليم المشاريع بكفاءة.',
    rating: 4.9,
    students: '2.9k',
    imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=480&q=80',
    accentColor: Color(0xFF12B76A),
  ),
];
