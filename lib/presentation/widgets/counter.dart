import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/presentation/state/counter/counter_cubit.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class Counter {
  static Widget person(
    BuildContext context,
    String type,
    String name,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextThemes.subtitle,
        ),
        BlocBuilder<CounterCubit, Map<String, int>>(
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
                      child: const Icon(
                        Icons.remove,
                        size: 16,
                      ),
                    ),
                  ),
                  Text(
                    '$count orang',
                    style: TextThemes.normal,
                  ),
                  // TextFormField(
                  //   controller: personController,
                  //   keyboardType: TextInputType.number,
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     hintText: 'Enter a number',
                  //   ),
                  //   onChanged: (value) {
                  //     // Dispatch event to update Cubit state
                  //     final newCount = int.tryParse(value) ?? count;
                  //     context.read<CounterCubit>().setCount(newCount);
                  //   },
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter a number';
                  //     }
                  //     final parsedValue = int.tryParse(value);
                  //     if (parsedValue == null) {
                  //       return 'Invalid number';
                  //     }
                  //     return null;
                  //   },
                  // ),
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
                      child: const Icon(
                        Icons.add,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
