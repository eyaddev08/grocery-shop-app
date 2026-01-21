import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shop_app/core/constants/app_colors.dart';
import '../../../../core/utils/functions/show_filter_modal.dart';
import '../../../../core/utils/functions/show_sort_modal.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../product_details/presentation/screens/product_details_screen.dart';
import '../../../products/presentation/widgets/product_shimmer_grid_view.dart';
import '../manager/search_cubit.dart';
import '../manager/search_state.dart';
import '../widgets/popular_tags.dart';
import '../widgets/product_list_header.dart';
import '../widgets/search_bar.dart';
import '../widgets/suggestions_list.dart';
import '../widgets/result_grid_view.dart';
import '../widgets/popular_tags_shimmer.dart';

import '../widgets/recent_searches_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SearchCubit>().resetSearch();
      }
    });

    // Listen to controller changes to update UI state (empty vs typing)
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSuggestionSelected(String text) {
    _searchController.text = text;
    _searchController.selection =
        TextSelection.fromPosition(TextPosition(offset: text.length));
    context.read<SearchCubit>().executeSearch(text);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        extendBodyBehindAppBar: true,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomAppBarWidget(
              label: 'Search', showSearchIcon: false, isBackButtonExist: true),
        ),
        body: SafeArea(
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                    color: kPrimaryBlue,
                    border: Border.all(width: 0, color: kPrimaryBlue)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: AppSearchBar(
                    controller: _searchController,
                    hintText: 'Search Products or store',
                    onChanged: (q) =>
                        context.read<SearchCubit>().onQueryChanged(q),
                    onSearch: () => context
                        .read<SearchCubit>()
                        .executeSearch(_searchController.text),
                    onClear: () {
                      _searchController.clear();
                      context.read<SearchCubit>().loadSuggestions('');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchSuggestionsLoading) {
                      return const Center(
                          child:
                              CircularProgressIndicator(color: kPrimaryBlue));
                    } else if (state is SearchSuggestionsLoaded) {
                      if (_searchController.text.isEmpty) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RecentSearchesWidget(
                                  onSearch: _onSuggestionSelected,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Popular Tags',
                                  style: textBold.copyWith(
                                    fontSize: 16,
                                    color: kTextDark,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                PopularTags(
                                  tags: const [
                                    'Search for "Apple"',
                                    'Water',
                                    'Juice',
                                    'Clownfish',
                                    'Gold Fish',
                                    'Blue Tang',
                                    'Vibrant Yellow Fish',
                                    'Golden Fish Profile',
                                    'Fresh Bass White',
                                    'Bundle (3 pcs)',
                                  ],
                                  onTagTap: _onSuggestionSelected,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      if (state.suggestions.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child:
                                Text('No suggestions found', style: textBold),
                          ),
                        );
                      }
                      return SuggestionsList(
                        suggestions: state.suggestions,
                        onSuggestionSelected: _onSuggestionSelected,
                      );
                    } else if (state is SearchLoading) {
                      return const ProductShimmerGridView();
                    } else if (state is SearchLoaded) {
                      if (state.result.products.isEmpty) {
                        return _buildEmpty();
                      }
                      return Column(
                        children: [
                          ProductListHeader(
                            onSortTap: () => showSortModal(context, state),
                            onFilterTap: () => showFilterModal(context, state),
                          ),
                          Expanded(
                            child: ResultGridView(
                              result: state.result,
                              isLoadingMore: state.isPaginationLoading,
                              onLoadMore: () =>
                                  context.read<SearchCubit>().loadNextPage(),
                              onTapProduct: (product) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (builder) =>
                                            ProductDetailsScreen(
                                                initialProduct: product)));
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is SearchEmpty) {
                      return _buildEmpty();
                    } else if (state is SearchError) {
                      return Center(child: Text(state.message));
                    }
                    return const PopularTagsShimmer();
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildEmpty() => const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 72, color: kPrimaryBlue),
            SizedBox(height: 12),
            Text(
              'No results Found',
              style: textBold,
            ),
          ],
        ),
      );
}
