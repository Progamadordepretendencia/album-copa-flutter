import 'package:equatable/equatable.dart';

import '../../../models/user_model.dart';

enum HomeStatus {
  initial,
  logout,
  loaded,
  error,
  loading;
}

class HomeState extends Equatable {
  final HomeStatus status;
  final UserModel? user;
  final String? message;

  const HomeState({
    required this.status,
    this.user,
    this.message,
  });

  const HomeState.initial() : this(status: HomeStatus.initial);

  @override
  List<Object?> get props => [status, user, message];

  HomeState copyWith({
    HomeStatus? status,
    UserModel? user,
    String? message,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
