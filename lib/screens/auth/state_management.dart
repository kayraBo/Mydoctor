import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userLogged = StateProvider((ref) => FirebaseAuth.instance.currentUser);
final selectedMs = StateProvider((ref) => '');
final selectedDoctor = StateProvider((ref) => '');
final selectedTime = StateProvider((ref) => '');
