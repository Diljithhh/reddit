import 'package:flutter/material.dart';
import 'package:reddit/Features/Auth/Screens/login_screen.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
'/':(_) => const MaterialPage(child: LoginScreen())


});
