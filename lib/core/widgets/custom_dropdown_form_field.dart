import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../utils/custom_themes.dart';

class CustomDropdownFormField<T> extends StatefulWidget {
  const CustomDropdownFormField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hint,
    this.validator,
    this.dropdownColor,
    this.maxHeight = 220,
  });

  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? hint;
  final String? Function(T?)? validator;
  final Color? dropdownColor;
  final double maxHeight;

  @override
  State<CustomDropdownFormField<T>> createState() =>
      _CustomDropdownFormFieldState<T>();
}

class _CustomDropdownFormFieldState<T> extends State<CustomDropdownFormField<T>>
    with SingleTickerProviderStateMixin {
  final GlobalKey _targetKey = GlobalKey();
  final GlobalKey<FormFieldState<T>> _formFieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlay;
  bool _open = false;

  late final AnimationController _anim;
  late final Animation<double> _fade;

  static const double _itemHeight = 48;
  static const double _radius = 12;
  static const double _verticalPad = 8;
  static const Color _dividerColor = Color(0xFFF1F2F6);

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 180));
    _fade = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownFormField<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // sync FormField value with external value
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _formFieldKey.currentState?.didChange(widget.value);
    });
  }

  @override
  void dispose() {
    _removeOverlay(callSetState: false);
    _anim.dispose();
    super.dispose();
  }

  void _toggle() {
    _open ? _removeOverlay() : _showOverlay();
  }

  void _showOverlay() {
    final renderBox =
        _targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final pos = renderBox.localToGlobal(Offset.zero);
    final contentHeight = min(
        widget.items.length * _itemHeight + (_verticalPad * 2),
        widget.maxHeight);
    final showAbove = pos.dy > (contentHeight + 20);

    final top =
        showAbove ? pos.dy - contentHeight - 8 : pos.dy + size.height + 8;
    final left = pos.dx;
    final width = size.width;

    _overlay = OverlayEntry(
      builder: (_) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _removeOverlay,
        child: Stack(
          children: [
            Positioned(
              left: left,
              top: top,
              width: width,
              child: CompositedTransformFollower(
                link: _layerLink,
                showWhenUnlinked: false,
                offset: Offset(0, 0),
                child: FadeTransition(
                  opacity: _fade,
                  child: Material(
                    color: Colors.transparent,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: contentHeight),
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.dropdownColor ?? Colors.white,
                          borderRadius: BorderRadius.circular(_radius),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 18,
                                offset: const Offset(0, 8))
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          shrinkWrap: true,
                          itemCount: widget.items.length,
                          itemBuilder: (_, i) {
                            final item = widget.items[i];
                            final selected = item.value == widget.value;
                            return InkWell(
                              onTap: () {
                                widget.onChanged(item.value);
                                _formFieldKey.currentState
                                    ?.didChange(item.value);
                                _removeOverlay();
                              },
                              child: Container(
                                height: _itemHeight,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                alignment: Alignment.centerLeft,
                                color: selected
                                    ? (kPrimaryBlue.withOpacity(0.06))
                                    : Colors.transparent,
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    color: selected ? kPrimaryBlue : kTextDark,
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                  ),
                                  child: item.child,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(
                              height: 1, thickness: 1, color: _dividerColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlay!);
    setState(() => _open = true);
    _anim.forward(from: 0);
  }

  void _removeOverlay({bool callSetState = true}) {
    _overlay?.remove();
    _overlay = null;
    if (callSetState && mounted) {
      setState(() => _open = false);
    } else {
      _open = false;
    }
  }

  Widget _selectedChild() {
    try {
      final match = widget.items.firstWhere((it) => it.value == widget.value);
      return match.child;
    } catch (_) {
      return Text(widget.hint ?? '',
          style: const TextStyle(
              color: Color(0xFF9AA0B4), fontSize: 14, fontFamily: 'Poppins'));
    }
  }

  @override
  Widget build(BuildContext context) => FormField<T>(
        key: _formFieldKey,
        initialValue: widget.value,
        validator: widget.validator,
        builder: (state) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                key: _targetKey,
                onTap: _toggle,
                child: InputDecorator(
                  isFocused: _open,
                  decoration: InputDecoration(
                    labelText: widget.label,
                    labelStyle: textBold.copyWith(
                      color: kMuted,
                      fontSize: 18,
                    ),
                    hintStyle: textBold.copyWith(
                      color: kMuted,
                      fontSize: 16,
                    ),
                    hintText: widget.hint,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE9EAF4)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: kPrimaryBlue, width: 1.2),
                    ),
                    errorText: state.errorText,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Icon(
                          _open
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: kPrimaryBlue),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(child: _selectedChild()),
                      // suffixIcon is already provided by decoration
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
