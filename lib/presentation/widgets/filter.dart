import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/enum.dart';
import 'package:sop_mobile/presentation/state/date/date_cubit.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';
import 'package:sop_mobile/presentation/state/filter/filter_event.dart';
import 'package:sop_mobile/presentation/state/filter/filter_state.dart';
import 'package:sop_mobile/presentation/widgets/filter_button.dart';
import 'package:sop_mobile/presentation/widgets/date.dart';

class Filter {
  static Future<void> onActPressed(
    BuildContext context,
    FilterType filterType,
  ) async {
    final bloc = context.read<FilterBloc>();
    final blocState = bloc.state;
    final cubit = context.read<DateCubit>();

    log('Filter button pressed: $filterType');
    if (blocState.activeFilter.contains(filterType)) {
      bloc.add(FilterRemoved(filterType, cubit.getDate()));
    } else {
      bloc.add(FilterAdded(filterType, cubit.getDate()));
    }
  }

  static Future<void> onRefreshOrDateChanged(BuildContext context) async {
    log('Refreshed or Date changed');
    final bloc = context.read<FilterBloc>();
    final cubit = context.read<DateCubit>();

    log('Date changed: ${cubit.getDate()}');
    bloc.add(FilterModified(cubit.getDate()));
  }

  static Widget type1(BuildContext context) {
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: isTablet ? 100 : 50, // Taller on tablets, shorter on phones
      child: Row(
        spacing: 8,
        children: [
          // ~:Filter Icon:~
          FilterButton.iconOnly(Icons.filter_list_alt),

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
                      final isActive = state.activeFilter.contains(
                        FilterType.briefing,
                      );

                      log('Active Filter: ${state.activeFilter}');

                      // context.read<FilterBloc>().add(LoadFilterData());
                      return FilterButton.textButton(
                        () => onActPressed(context, FilterType.briefing),
                        'Morning Briefing',
                        isActive,
                      );
                    },
                  ),

                  // ~:Daily Report:~
                  BlocBuilder<FilterBloc, FilterState>(
                    builder: (context, state) {
                      final isActive = state.activeFilter.contains(
                        FilterType.report,
                      );

                      log('Active Filter: ${state.activeFilter}');

                      return FilterButton.textButton(
                        () => onActPressed(context, FilterType.report),
                        'Daily Report',
                        isActive,
                      );
                    },
                  ),

                  // ~:Salesman:~
                  // BlocBuilder<FilterBloc, FilterState>(
                  //   builder: (context, state) {
                  //     final isActive =
                  //         state.activeFilter.contains(FilterType.salesman);
                  //
                  //     log('Active Filter: ${state.activeFilter}');
                  //
                  //     return FilterButton.textButton(
                  //       () => onActPressed(context, FilterType.salesman),
                  //       'Salesman',
                  //       isActive,
                  //     );
                  //   },
                  // ),

                  // ~:Date:~
                  BlocBuilder<DateCubit, String>(
                    builder: (context, state) {
                      final cubit = context.read<DateCubit>();

                      return FilterButton.dateButton(
                        () => DatePicker.single(context),
                        cubit.getDate(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
