import 'package:flutter/material.dart';
import '../../../../features/products/presentation/widgets/product_card.dart';
import '../../domain/entities/search_result.dart';
import '../../../../features/products/domain/entities/product_entity.dart';

class ResultGridView extends StatefulWidget {
  final SearchResult result;
  final bool isLoadingMore;
  final VoidCallback onLoadMore;
  final ValueChanged<ProductEntity>? onTapProduct;

  const ResultGridView({
    super.key,
    required this.result,
    required this.isLoadingMore,
    required this.onLoadMore,
    this.onTapProduct,
  });

  @override
  State<ResultGridView> createState() => _ResultGridViewState();
}

class _ResultGridViewState extends State<ResultGridView> {
  late final ScrollController _scrollController;
  bool _isRequestingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant ResultGridView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isLoadingMore && !widget.isLoadingMore) {
      _isRequestingMore = false;
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_isRequestingMore || widget.isLoadingMore) return;
    if (widget.result.nextCursor == null) return;

    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    final threshold = max * 0.7;

    if (current >= threshold) _requestMore();
  }

  void _requestMore() {
    _isRequestingMore = true;
    try {
      widget.onLoadMore();
    } catch (_) {
      _isRequestingMore = false;
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  int _calcCrossAxisCount(double width) {
    if (width >= 1100) return 5;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  double _calcChildAspectRatio(double width, int crossAxisCount) {
    final tileWidth =
        (width - 16 * 2 - (crossAxisCount - 1) * 16) / crossAxisCount;
    final tileHeight = tileWidth * 1.35;
    return tileWidth / tileHeight;
  }

  @override
  Widget build(BuildContext context) {
    final products = widget.result.products;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;
      final crossAxisCount = _calcCrossAxisCount(width);
      final childAspectRatio = _calcChildAspectRatio(width, crossAxisCount);

      if (products.isEmpty) {
        return const Center(
          child: Text('لم يتم العثور على نتائج',
              style: TextStyle(color: Colors.grey)),
        );
      }

      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = products[index];

                  // Build card
                  final card = ProductCard(product: product);

                  // If caller provided onTapProduct, wrap card to intercept taps.
                  if (widget.onTapProduct != null) {
                    return GestureDetector(
                      onTap: () => widget.onTapProduct!(product),
                      child: card,
                    );
                  }

                  // Otherwise return card as-is (it may handle its own tap)
                  return card;
                },
                childCount: products.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: childAspectRatio,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: widget.isLoadingMore
                      ? const SizedBox(
                          key: ValueKey('pagination_loader'),
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(strokeWidth: 2.8),
                        )
                      : const SizedBox.shrink(key: ValueKey('empty_loader')),
                ),
              ),
            ),
          ),
          const SliverPadding(
              padding: EdgeInsets.only(bottom: 32),
              sliver: SliverToBoxAdapter(child: SizedBox.shrink())),
        ],
      );
    });
  }
}
