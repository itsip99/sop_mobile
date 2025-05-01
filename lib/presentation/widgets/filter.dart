import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/widgets/filter_button.dart';

class Filter {
  static Widget type1(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.height < 800) ? 50 : 100,
      child: Row(
        children: [
          FilterButton.iconOnly(),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  FilterButton.textButton(() {}, 'Morning Briefing'),
                  FilterButton.textButton(() {}, 'Daily Report'),
                  FilterButton.textButton(() {}, 'Salesman'),
                  FilterButton.textButton(() {}, '30-04-2025'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
