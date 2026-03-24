import 'package:flutter/material.dart';

class SliderCard extends StatefulWidget {
  const SliderCard({
    required this.title,
    required this.value,
    required this.unit,
    required this.min,
    required this.max,
    required this.onChanged,
    super.key,
  });

  final String title;
  final double value;
  final String unit;
  final double min;
  final double max;
  final Function(double) onChanged;

  @override
  State<SliderCard> createState() => _SliderCardState();
}

class _SliderCardState extends State<SliderCard> {
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: t.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title, style: t.textTheme.bodyMedium),
              Text(
                "${widget.value.toInt()} ${widget.unit}",
                style: TextStyle(
                  color: t.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Slider(
            value: widget.value,
            min: widget.min,
            max: widget.max,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
