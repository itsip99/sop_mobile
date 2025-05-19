import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sop_mobile/presentation/state/filter/filter_bloc.dart';

class Refresh {
  static Widget iOSnAndroid({
    required Widget child,
    required Function onRefresh,
    required FilterBloc filterBloc,
    bool isLoading = false,
    bool isError = false,
    String? errorMessage,
  }) {
    if (Platform.isIOS) {
      return CustomScrollView(
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: () => onRefresh()),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, _) => SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: child,
              ),
              childCount: 1,
            ),
          ),
        ],
      );
    } else {
      return RefreshIndicator(
        onRefresh: () => onRefresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: child,
        ),
      );
    }
  }
}
