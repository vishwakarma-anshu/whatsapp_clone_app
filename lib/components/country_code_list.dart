import 'package:flutter/material.dart';
import 'package:whatsapp_clone_app/models/country.dart';

class CountryCodeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme,
        iconTheme: Theme.of(context).iconTheme,
        title: Text('Choose a country'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: countries.length,
        itemBuilder: (BuildContext context, int index) {
          Country country = countries[index];

          return ListTile(
            leading: Image.asset(country.flagSrc, width: 40.0),
            title: Text(country.name),
            trailing: Text(
              '+${country.dialingCode}',
              style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.w800, color: Colors.grey.shade500),
            ),
            onTap: () {
              Navigator.pop(context, country);
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider();
        },
      ),
    );
  }
}
