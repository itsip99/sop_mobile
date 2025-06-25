import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Refresh {
  static Widget iOSnAndroid({
    required Widget child,
    required Function onRefresh,
    bool isLoading = false,
    bool isError = false,
    String? errorMessage,
    bool isDisabled = false,
  }) {
    if (!isDisabled) {
      if (Platform.isIOS) {
        return CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: () async => onRefresh()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, _) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: child,
                ),
                childCount: 1,
              ),
            ),
          ],
        );
      } else {
        return RefreshIndicator(
          onRefresh: () async => onRefresh(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: child,
          ),
        );
      }
    } else {
      return const SizedBox();
    }
  }
}
