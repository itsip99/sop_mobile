import 'package:flutter/material.dart';
import 'package:sop_mobile/core/constant/colors.dart';
import 'package:sop_mobile/core/helpers/formatter.dart';
import 'package:sop_mobile/data/models/sales.dart';
import 'package:sop_mobile/presentation/themes/styles.dart';

class SalesmanProfileCard extends StatefulWidget {
  const SalesmanProfileCard({
    super.key,
    required this.salesman,
    required this.onStatusChanged,
    this.isPreview = false,
  });

  final SalesModel salesman;
  final Function(bool isActive) onStatusChanged;
  final bool isPreview;

  @override
  State<SalesmanProfileCard> createState() => _SalesmanProfileCardState();
}

class _SalesmanProfileCardState extends State<SalesmanProfileCard> {
  bool _isActive = false;

  @override
  void initState() {
    super.initState();

    // Initialize the local state from the data passed in
    _isActive = widget.salesman.isActive == 1;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          _isActive
              ? ConstantColors.primaryColor2
              : ConstantColors.disabledColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 5,
      shadowColor: ConstantColors.shadowColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        title: Text(
          'ID ${widget.salesman.id}',
          style: TextThemes.normal.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${Formatter.toTitleCase(widget.salesman.userName)} - ${Formatter.toTitleCase(widget.salesman.tierLevel)}',
          style: TextThemes.normal,
        ),
        trailing:
            widget.isPreview
                ? null
                : Transform.scale(
                  scale: 0.85,
                  child: Switch(
                    // The switch is now controlled by the local _isActive state
                    value: _isActive,
                    onChanged: (newValue) {
                      // 1. Instantly update the UI of THIS card by calling setState
                      setState(() {
                        _isActive = newValue;
                      });
                      // 2. Notify the parent/Bloc about the change in the background
                      widget.onStatusChanged(newValue);
                    },
                    activeColor: ConstantColors.primaryColor1,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
      ),
    );
  }
}
