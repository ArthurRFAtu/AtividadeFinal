import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../User.dart';

class ListaDeUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final userList = userData.users;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];

          return UserTile(user: user);
        },
      ),
    );
  }
}

class UserTile extends StatefulWidget {
  final Map<String, dynamic> user;

  const UserTile({required this.user});

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    final imagePath = user['imagePath'];

    return Column(
      children: [
        ListTile(
          leading: imagePath != null
              ? Image.network(
                  imagePath,
                  width: 40,
                  height: 40,
                )
              : CircleAvatar(
                  child: Icon(Icons.person),
                ),
          title: Text(user['name']),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 8),
            child: Text('Matrícula: ${user['registration']}'),
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          trailing:
              _isExpanded ? Icon(Icons.expand_less) : Icon(Icons.expand_more),
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          tileColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          selected: _isExpanded,
          selectedTileColor: Colors.white,
          dense: !_isExpanded,
          isThreeLine: _isExpanded,
          visualDensity: VisualDensity.compact,
        ),
        if (_isExpanded) ..._buildExpandedContent(user),
      ],
    );
  }

  List<Widget> _buildExpandedContent(Map<String, dynamic> user) {
    return [
      if (user['imagePath'] != null)
        Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Image.network(user['imagePath']),
        ),
      ListTile(
        title: Text('Escola: ${user['school']}'),
      ),
      ListTile(
        title: Text('Período: ${user['period']}'),
      ),
    ];
  }
}
