import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';

import 'package:grocery_shop_app/features/search/domain/entities/suggestion.dart';
import 'package:grocery_shop_app/features/search/presentation/manager/search_cubit.dart';

import '../../../../core/utils/styles.dart';
import '../manager/search_state.dart';
import 'search_history_chip.dart';

class RecentSearchesWidget extends StatelessWidget {

  const RecentSearchesWidget({
    super.key,
    required this.onSearch,
  });
  final void Function(String) onSearch;

  @override
  Widget build(BuildContext context) => BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          List<Suggestion> history = [];
          if (state is SearchSuggestionsLoaded) {
            history = state.suggestions
                .where((s) => s.type == SuggestionType.history)
                .toList();
          }
          if (history.isEmpty) {
            return const SizedBox.shrink();
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Searches',
                      style: textBold.copyWith(
                        fontSize: 16,
                        color: kTextDark,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<SearchCubit>().clearHistory();
                      },
                      child: Text(
                        'Clear All',
                        style: textMedium.copyWith(
                          color: kPrimaryBlue,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: history
                    .map((suggestion) =>
                        SearchHistoryChip(text: suggestion.text, onSearch: onSearch))
                    .toList(),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      );
      }
