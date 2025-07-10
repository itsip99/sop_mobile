import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class Counter {
  static Widget automaticPerson(
    BuildContext context,
    String type,
    String name,
  ) {
    return Row(
      children: [
        Expanded(child: Text(name, style: TextThemes.subtitle)),
        Expanded(
          child: BlocBuilder<CounterCubit, Map<String, int>>(
            builder: (context, state) {
              final total =
                  (state['shop_manager'] ?? 0) +
                  (state['sales_counter'] ?? 0) +
                  (state['salesman'] ?? 0) +
                  (state['others'] ?? 0);

              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(
                  '$total orang',
                  style: TextThemes.normal.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget person(BuildContext context, String type, String name) {
    return Row(
      children: [
        Expanded(child: Text(name, style: TextThemes.subtitle)),
        Expanded(
          child: BlocBuilder<CounterCubit, Map<String, int>>(
            builder: (context, map) {
              final count = map[type] ?? 1;

              return Container(
                decoration: BoxDecoration(
                  color: ConstantColors.primaryColor1,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(8),
                child: Wrap(
                  spacing: 12,
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => context.read<CounterCubit>().decrement(type),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ConstantColors.primaryColor2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.remove, size: 16),
                      ),
                    ),
                    Text('$count orang', style: TextThemes.normal),
                    InkWell(
                      onTap: () => context.read<CounterCubit>().increment(type),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ConstantColors.primaryColor2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.add, size: 16),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
