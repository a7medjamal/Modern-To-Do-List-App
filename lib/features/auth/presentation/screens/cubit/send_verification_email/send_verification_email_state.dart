import 'package:equatable/equatable.dart';

abstract class SendVerificationEmailState extends Equatable {
  const SendVerificationEmailState();

  @override
  List<Object?> get props => [];
}

class SendVerificationEmailInitial extends SendVerificationEmailState {}

class SendVerificationEmailLoading extends SendVerificationEmailState {}

class SendVerificationEmailSuccess extends SendVerificationEmailState {}

class SendVerificationEmailFailure extends SendVerificationEmailState {
  final String message;

  const SendVerificationEmailFailure(this.message);

  @override
  List<Object?> get props => [message];
}
