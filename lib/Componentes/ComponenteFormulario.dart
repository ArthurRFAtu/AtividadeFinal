import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ListaDeUsuario.dart';
import '../User.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FormComponent extends StatefulWidget {
  @override
  _FormComponentState createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _registrationController = TextEditingController();
  final _schoolController = TextEditingController();
  final _periodController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _registrationController.dispose();
    _schoolController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedImage != null) {
        _selectedImage = File(pickedImage.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuários'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _registrationController,
                decoration: InputDecoration(labelText: 'Matrícula'),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ], // Permitir apenas dígitos
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite a matrícula';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _schoolController,
                decoration: InputDecoration(labelText: 'Escola'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite a escola';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _periodController,
                decoration: InputDecoration(labelText: 'Período'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite o período';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 40.0,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.blue, 
                  borderRadius: BorderRadius.circular(10.0), 
                  border: Border.all(color: Colors.black), 
                ),
                child: InkWell(
                  onTap: _pickImage,
                  splashColor: Colors.white, 
                  child: Center(
                    child: Text(
                      'Selecionar Imagem',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
              if (_selectedImage != null) ...[
                SizedBox(height: 16.0),
                Image.network(
                  _selectedImage!.path,
                  height: 150,
                ),
              ],
              SizedBox(height: 16.0),
              Container(
                width: double.infinity,
                height: 40.0,
                margin: EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.green, // Cor do botão
                  borderRadius: BorderRadius.circular(10.0), 
                  border: Border.all(color: Colors.black), 
                ),
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      final userData =
                          Provider.of<UserData>(context, listen: false);

                      final user = {
                        'name': _nameController.text,
                        'registration': int.parse(_registrationController.text),
                        'school': _schoolController.text,
                        'period': _periodController.text,
                        'imagePath':
                            _selectedImage != null ? _selectedImage!.path : null,
                      };

                      userData.addUser(user);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListaDeUsuario(),
                        ),
                      );
                    }
                  },
                  splashColor: Colors.white, 
                  child: Center(
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
