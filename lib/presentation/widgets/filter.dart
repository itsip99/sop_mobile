import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/widgets/filter_button.dart';

class Filter {
  static filterButton(
    BuildContext context,
    FilterType filterType,
  ) {
    final bloc = context.read<FilterBloc>();
    final blocState = bloc.state;

    log('Filter button pressed: $filterType');
    if (blocState.activeFilter.contains(filterType)) {
      bloc.add(FilterRemoved(filterType));
    } else {
      bloc.add(FilterAdded(filterType));
    }
  }

  static Widget type1(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.height < 800) ? 50 : 100,
      child: Row(
        children: [
          // ~:Filter Icon:~
          FilterButton.iconOnly(),

          // ~:Divider:~
          const SizedBox(width: 8),

          // ~:Filter Options:~
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  // ~:Morning Briefing:~
                  BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                    final isActive =
                        state.activeFilter.contains(FilterType.briefing);

                    return FilterButton.textButton(
                      () => filterButton(context, FilterType.briefing),
                      'Morning Briefing',
                      isActive,
                    );
                  }),

                  // ~:Daily Report:~
                  BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                    final isActive =
                        state.activeFilter.contains(FilterType.report);

                    return FilterButton.textButton(
                      () => filterButton(context, FilterType.report),
                      'Daily Report',
                      isActive,
                    );
                  }),

                  // ~:Salesman:~
                  BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                    final isActive =
                        state.activeFilter.contains(FilterType.salesman);

                    return FilterButton.textButton(
                      () => filterButton(context, FilterType.salesman),
                      'Salesman',
                      isActive,
                    );
                  }),

                  // ~:Date:~
                  FilterButton.dateButton(() {}, '30-04-2025'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
