import 'package:flutter/material.dart';

@immutable
sealed class GenreEvent{}

class OnRequest extends GenreEvent{}