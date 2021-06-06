import 'package:meta/meta.dart';

@immutable
class SignUpState {

  final bool isNameEmpty;
  final bool isNumEmpty;
  final bool isLocationEmpty;
  final bool isPhotoEmpty;
  bool isSubmitting;
  bool isSuccess;
  bool isFailure;

  bool get isFormValid =>
      isPhotoEmpty &&
          isNameEmpty &&
          isNumEmpty &&
          isPhotoEmpty &&
          isLocationEmpty;


  SignUpState(
      {
        @required this.isNameEmpty,
        @required this.isNumEmpty,
        @required this.isPhotoEmpty,
        @required this.isLocationEmpty,
        @required this.isSubmitting,
        @required this.isSuccess,
        @required this.isFailure});

  //initial state
  factory SignUpState.empty() {
    return SignUpState(
      isNameEmpty: false,
      isNumEmpty: false,
      isPhotoEmpty: false,
      isLocationEmpty: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory SignUpState.loading() {
    return SignUpState(
      isNameEmpty: false,
      isNumEmpty: false,
      isPhotoEmpty: false,
      isLocationEmpty: false,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory SignUpState.failure() {
    return SignUpState(
      isNameEmpty: false,
      isNumEmpty: false,
      isPhotoEmpty: false,
      isLocationEmpty: false,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
    );
  }

  factory SignUpState.success() {
    return SignUpState(
      isNameEmpty: false,
      isNumEmpty: false,
      isPhotoEmpty: false,
      isLocationEmpty: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
    );
  }

  // SignUpState update({
  //   bool isEmailValid,
  //   bool isPasswordValid,
  // }) {
  //   return copyWith(
  //     isEmailValid: isEmailValid,
  //     isPasswordValid: isPasswordValid,
  //     isSubmitting: false,
  //     isFailure: false,
  //     isSuccess: false,
  //   );
  // }

  SignUpState copyWith({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isNumEmpty,
    bool isLocationEmpty,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return SignUpState(
        isNameEmpty: isNameEmpty ?? this.isNameEmpty,
        isNumEmpty: isNumEmpty ?? this.isNumEmpty,
        isPhotoEmpty: isPhotoEmpty ?? this.isPhotoEmpty,
        isLocationEmpty: isLocationEmpty?? this.isLocationEmpty,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

}