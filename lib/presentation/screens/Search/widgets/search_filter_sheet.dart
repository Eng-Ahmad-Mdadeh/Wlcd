import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/core/resources/app_values.dart';
import 'package:wlcd/presentation/widgets/custom_radio_tile.dart';
import 'package:wlcd/presentation/widgets/text/body_title.dart';
import 'package:wlcd/presentation/widgets/text/section_title.dart';

class SearchFilterResult {
  const SearchFilterResult({required this.level, this.topic, this.rating, this.clear = false});
  final String level;
  final String? topic;
  final double? rating;
  final bool clear;
}

class SearchFilterCubit extends Cubit<SearchFilterResult> {
  SearchFilterCubit({required String initialLevel, String? initialTopic, double? initialRating})
      : super(SearchFilterResult(level: initialLevel, topic: initialTopic, rating: initialRating));

  void selectTopic(String? topic) => emit(SearchFilterResult(level: state.level, topic: topic, rating: state.rating));
  void selectRating(double? rating) => emit(SearchFilterResult(level: state.level, topic: state.topic, rating: rating));
  void selectLevel(String level) => emit(SearchFilterResult(level: level, topic: state.topic, rating: state.rating));
  void clear() => emit(const SearchFilterResult(level: 'all', clear: true));
}

class SearchFilterSheet extends StatelessWidget {
  const SearchFilterSheet({super.key, required this.initialTopic, required this.initialRating, required this.initialLevel});
  final String? initialTopic;
  final double? initialRating;
  final String initialLevel;

  static const ratings = [5.0, 4.5, 4.0, 3.5];
  static const topics = ['Business', 'Finance', 'Graphic Design', 'UX Design', 'Design', 'Website'];
  static const levels = ['all', 'beginner', 'intermediate'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchFilterCubit(initialLevel: initialLevel, initialTopic: initialTopic, initialRating: initialRating),
      child: BlocBuilder<SearchFilterCubit, SearchFilterResult>(
        builder: (context, state) {
          return Column(
            children: [
              ExpansionTile(
                title: const SectionTitle(text: 'Ratings'),
                children: [
                  Wrap(
                    spacing: 8,
                    children: ratings
                        .map((value) => ChoiceChip(
                              label: Text('$value+'),
                              selected: state.rating == value,
                              onSelected: (_) => context.read<SearchFilterCubit>().selectRating(value),
                            ))
                        .toList(),
                  ),
                ],
              ),
              ExpansionTile(
                initiallyExpanded: true,
                title: const SectionTitle(text: 'Topics'),
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: topics
                        .map((topic) => ChoiceChip(
                              label: Text(topic),
                              selected: state.topic == topic,
                              onSelected: (_) => context.read<SearchFilterCubit>().selectTopic(topic),
                            ))
                        .toList(),
                  ),
                ],
              ),
              ExpansionTile(
                title: const SectionTitle(text: 'Level'),
                children: levels
                    .map((level) => CustomRadioTile<String>(
                          option: level,
                          selectedOption: state.level,
                          onChanged: context.read<SearchFilterCubit>().selectLevel,
                          title: BodyTitle(text: level[0].toUpperCase() + level.substring(1)),
                        ))
                    .toList(),
              ),
              const Spacer(),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<SearchFilterCubit>().clear();
                      Navigator.of(context).pop(context.read<SearchFilterCubit>().state);
                    },
                    child: const Text('Clear'),
                  ),
                ),
                SizedBox(width: AppWidth.w8),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    onPressed: () => Navigator.of(context).pop(context.read<SearchFilterCubit>().state),
                    child: const Text('Apply Filter'),
                  ),
                ),
              ]),
            ],
          );
        },
      ),
    );
  }
}
