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
    // bool isActive,
    // int index,
  ) {
    log('Filter button pressed: $filterType');
    if (filterType == FilterType.none) {
      context.read<FilterBloc>().add(UnselectedFilter(filterType));
    } else {
      context.read<FilterBloc>().add(SelectedFilter(filterType));
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
                    final isActive = state is FilterSelected &&
                        state.activeFilter == FilterType.briefing;

                    // ~:Unselected:~
                    if (state is FilterSelected && isActive) {
                      return FilterButton.textButton(
                        () => filterButton(context, FilterType.none),
                        'Morning Briefing',
                        isActive,
                      );
                    }

                    // ~:Default / Selected:~
                    return FilterButton.textButton(
                      () => filterButton(context, FilterType.briefing),
                      'Morning Briefing',
                      isActive,
                    );
                  }),

                  // ~:Daily Report:~
                  BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                    final isActive = state is FilterSelected &&
                        state.activeFilter == FilterType.report;

                    // ~:Unselected:~
                    if (state is FilterSelected) {
                      return FilterButton.textButton(
                        () => filterButton(context, FilterType.none),
                        'Daily Report',
                        isActive,
                      );
                    }

                    // ~:Default / Selected:~
                    return FilterButton.textButton(
                      () => filterButton(context, FilterType.report),
                      'Daily Report',
                      isActive,
                    );
                  }),

                  // ~:Salesman:~
                  BlocBuilder<FilterBloc, FilterState>(
                      builder: (context, state) {
                    final isActive = state is FilterSelected &&
                        state.activeFilter == FilterType.salesman;

                    // ~:Unselected:~
                    if (state is FilterSelected) {
                      return FilterButton.textButton(
                        () => filterButton(context, FilterType.none),
                        'Salesman',
                        isActive,
                      );
                    }

                    // ~:Default / Selected:~
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
