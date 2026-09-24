import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/catalog_pagination/catalog_pagination_model.dart';
import 'package:wlcd/data/model/catalog/course/course_model.dart';
import 'package:wlcd/data/model/instructor/instructor_specialty_model.dart';
import 'package:wlcd/data/model/instructor/public_contact_config_model.dart';

part 'instructor_model.g.dart';

@JsonSerializable(createToJson: false)
class InstructorModel extends Equatable {
  const InstructorModel({
    this.instructorId,
    this.profileSnapshotId,
    this.publicationVersion,
    this.displayName,
    this.biography,
    this.specialtyCategoryIds = const [],
    this.primarySpecialtyCategoryId,
    this.mediaId,
    this.publicContactConfig,
    this.publishedAt,
    this.specialty,
    this.rating,
    this.studentsCount,
    this.coursesCount,
    this.courses = const [],
    this.data = const [],
    this.pagination,
  });

  final String? instructorId;
  final String? profileSnapshotId;
  final int? publicationVersion;
  final String? displayName;
  final String? biography;
  final List<String> specialtyCategoryIds;
  final String? primarySpecialtyCategoryId;
  final String? mediaId;
  final PublicContactConfigModel? publicContactConfig;
  final DateTime? publishedAt;
  final InstructorSpecialtyModel? specialty;
  final double? rating;
  final int? studentsCount;
  final int? coursesCount;
  final List<CourseModel> courses;
  final List<InstructorModel> data;
  final CatalogPaginationModel? pagination;

  factory InstructorModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorModelFromJson(json);

  @override
  List<Object?> get props => [
    instructorId, profileSnapshotId, publicationVersion, displayName,
    biography, specialtyCategoryIds, primarySpecialtyCategoryId, mediaId,
    publicContactConfig, publishedAt, specialty, rating, studentsCount,
    coursesCount, courses, data, pagination,
  ];
}
