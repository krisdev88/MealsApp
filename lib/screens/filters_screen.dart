import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;

  const FiltersScreen(this.currentFilters, this.saveFilters, {Key key})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTitle(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
        title: Text(title),
        value: currentValue,
        subtitle: Text(description),
        onChanged: updateValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchListTitle(
                  'Gluten-free', 'Only include gluten-free meals.', _glutenFree,
                  (newValue) {
                return setState(() => _glutenFree = newValue);
              }),
              _buildSwitchListTitle(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) => setState(() => _lactoseFree = newValue)),
              _buildSwitchListTitle(
                'Vegetarian',
                'Only include vegetarian meals.',
                _vegetarian,
                (newValue) => setState(() => _vegetarian = newValue),
              ),
              _buildSwitchListTitle(
                'Vegan',
                'Only include vegan meals.',
                _vegan,
                (newValue) => setState(() => _vegan = newValue),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
