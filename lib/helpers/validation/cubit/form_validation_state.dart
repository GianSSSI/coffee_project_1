part of 'form_validation_cubit.dart';

class FormValidationState extends Equatable {
  final FieldInput fieldInput;
  final FormzSubmissionStatus status;
  final bool isValid;

  const FormValidationState({
    this.fieldInput = const FieldInput.pure(),
    this.status = FormzSubmissionStatus.success,
    this.isValid = false,
  });

  FormValidationState copyWith({
    FieldInput? fieldInput,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return FormValidationState(
      fieldInput: fieldInput ?? this.fieldInput,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [fieldInput, status, isValid];
}
