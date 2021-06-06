import 'package:meta/meta.dart';

@immutable
class AddProductState {

   bool isNameEmpty;
   bool isPriceEmpty;
   bool isPhotoEmpty;
  bool isSubmitting;
  bool isSuccess;
  bool isFailure;

  bool get isFormValid =>
      isPhotoEmpty &&
          isNameEmpty &&
          isPhotoEmpty &&
          isPriceEmpty;


  AddProductState(
      {
        @required bool isNameEmpty,
        @required bool isPriceEmpty,
        @required bool isPhotoEmpty,
        @required this.isSubmitting,
        @required this.isSuccess,
        @required this.isFailure});

  //initial state
  factory AddProductState.empty() {
    return AddProductState(
      isNameEmpty: false,
      isPriceEmpty: false,
      isPhotoEmpty: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory AddProductState.loading() {
    return AddProductState(
      isNameEmpty: false,
      isPriceEmpty: false,
      isPhotoEmpty: false,
      isSubmitting: true,
      isFailure: false,
      isSuccess: false,
    );
  }

  factory AddProductState.failure() {
    return AddProductState(
      isNameEmpty: false,
      isPriceEmpty: false,
      isPhotoEmpty: false,
      isSubmitting: false,
      isFailure: true,
      isSuccess: false,
    );
  }

  factory AddProductState.success() {
    return AddProductState(
      isNameEmpty: false,
      isPriceEmpty: false,
      isPhotoEmpty: false,
      isSubmitting: false,
      isFailure: false,
      isSuccess: true,
    );
  }



  AddProductState copyWith({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isPrice,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return AddProductState(
        isNameEmpty: isNameEmpty ?? this.isNameEmpty,
        isPriceEmpty: isPriceEmpty ?? this.isPriceEmpty,
        isPhotoEmpty: isPhotoEmpty ?? this.isPhotoEmpty,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

}