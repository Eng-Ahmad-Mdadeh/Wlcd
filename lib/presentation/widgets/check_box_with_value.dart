import 'package:wlcd/core/resources/app_colors.dart';
import 'package:wlcd/presentation/cubit/check_box/check_box_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckBoxWithValue extends StatefulWidget {
  final void Function(bool?)? onChanged;
  final bool value;

  const CheckBoxWithValue({
    super.key,
    required this.value, // القيمة الخارجية
    this.onChanged,
  });

  @override
  State<CheckBoxWithValue> createState() => _CheckBoxWithValueState();
}

class _CheckBoxWithValueState extends State<CheckBoxWithValue> {
  late CheckBoxCubit _checkBoxCubit; 

  @override
  void initState() {
    super.initState();
    _checkBoxCubit = CheckBoxCubit(initialValue: widget.value);
  }

  @override
  void didUpdateWidget(covariant CheckBoxWithValue oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      _checkBoxCubit.toggleUCheckBox(widget.value); 
    }
  }
  
  @override
  void dispose() {
    _checkBoxCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _checkBoxCubit,
      child: BlocBuilder<CheckBoxCubit, bool>(
        builder: (context, state) {
          return Checkbox(
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
            value: state, 
            activeColor: AppColors.primary,
            onChanged: (value) {
              if (value == null) return;
              
              _checkBoxCubit.toggleUCheckBox(value); 
              
              widget.onChanged?.call(value);
            },
          );
        },
      ),
    );
  }
}