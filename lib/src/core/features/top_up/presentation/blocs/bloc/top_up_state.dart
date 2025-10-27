part of 'top_up_bloc.dart';

class TopUpState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final ProviderEntity? selectedProvider;
  final Success? topUpResult;
  final bool isSuccess;

  const TopUpState({
    this.isLoading = false,
    this.errorMessage = '',
    this.selectedProvider,
    this.topUpResult,
    this.isSuccess = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    errorMessage,
    selectedProvider,
    topUpResult,
    isSuccess,
  ];

  TopUpState copyWith({
    bool? isLoading,
    String? errorMessage,
    ProviderEntity? selectedProvider,
    Success? topUpResult,
    bool? isSuccess,
  }) {
    return TopUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedProvider: selectedProvider ?? this.selectedProvider,
      topUpResult: topUpResult ?? this.topUpResult,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
