import 'package:book_app/Model/GenreModel.dart';
import 'package:book_app/View/genrePage/bloc/genre_event.dart';
import 'package:book_app/View/genrePage/bloc/genre_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenreBloc extends Bloc<GenreEvent, GenreState> {
  GenreBloc() : super(isInitial()) {
    on<OnRequest>(
      (event, emit) async {
        emit(isLoading());
        try {
          final url = '${dotenv.env['API_baseURL']}api/genres';
          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            final List<dynamic> data = jsonDecode(response.body);
            final List<GenreModel> genres =
                data.map((json) => GenreModel.fromJson(json)).toList();
            emit(isSuccess(genres));
          } else {
            emit(isError('Failed to load genres'));
          }
        } catch (e) {
          emit(isError('Error fetching genres: ${e.toString()}'));
        }
      },
    );
  }
}
