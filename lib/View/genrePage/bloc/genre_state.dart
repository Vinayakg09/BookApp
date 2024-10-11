import 'package:book_app/Model/GenreModel.dart';
import 'package:flutter/material.dart';

@immutable
sealed class GenreState {}

final class isInitial extends GenreState {}

final class isLoading extends GenreState {}

final class isSuccess extends GenreState {
  final List<GenreModel> genres;

  isSuccess(this.genres);
}

final class isError extends GenreState {
  final String message;
  isError(this.message);
}
