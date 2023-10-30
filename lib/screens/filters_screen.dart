import 'package:flutter/material.dart';
import 'package:flutter_proj5meal/screens/tabs_screen.dart';

import '../widgets/main_drawer.dart';

import 'dart:developer';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  var _vegan;
  var _vegeterian;
  var _lactoseFree;
  var _glutenFree;

  final Function setfilters;
  final Map<String, bool> filters;

  FiltersScreen(this.setfilters, this.filters) {
    // print(filters['vegan'].toString());
    _vegan = filters['vegan'];
    _vegeterian = filters['vegetarian'];
    _lactoseFree = filters['lactose'];
    _glutenFree = filters['gluten'];
  }

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    void Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    // print("==> ${widget.filters['vegan'].toString()}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final Map<String, bool> selectedFilters = {
                'gluten': widget._glutenFree,
                'lactose': widget._lactoseFree,
                'vegan': widget._vegan,
                'vegetarian': widget._vegeterian,
              };
              widget.setfilters(selectedFilters);
              Navigator.of(context).pushReplacementNamed(TabsScreen.routename);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  widget._glutenFree,
                  (newValue) {
                    setState(
                      () {
                        widget._glutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  widget._lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        widget._lactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  widget._vegeterian,
                  (newValue) {
                    setState(
                      () {
                        widget._vegeterian = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  widget._vegan,
                  (newValue) {
                    setState(
                      () {
                        widget._vegan = newValue;
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
