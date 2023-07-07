import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'User.dart';
import 'Componentes/ComponenteFormulario.dart';
import 'Componentes/ListaDeUsuario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: MaterialApp(
        title: 'App Matricula',
        initialRoute: '/',
        routes: {
          '/': (context) => FormComponent(),
          '/user-list': (context) => ListaDeUsuario(),
        },
      ),
    );
  }
}
