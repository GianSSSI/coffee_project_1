import 'package:coffee/features/coffee/model/validation/field_input.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'form_validation_state.dart';

class FormValidationCubit extends Cubit<FormValidationState> {
  FormValidationCubit() : super(FormValidationState());

  void inputChanged(String value) {
    final input = value.isEmpty
        ? const FieldInput.pure()
        : FieldInput.dirty(value);
    final isValid = input.isValid;

    emit(
      state.copyWith(
        fieldInput: input,
        isValid: isValid,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }
}
