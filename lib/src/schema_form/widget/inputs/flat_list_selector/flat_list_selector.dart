import 'package:flutter/material.dart';

class FlatListSelector extends StatefulWidget {
  final String label;
  final List<Map<String, dynamic>> vehicleTypes;
  final Function(int) onSelected;
  final String? initialValue;

  const FlatListSelector({super.key, required this.label, required this.vehicleTypes, required this.onSelected, this.initialValue});

  @override
  State<FlatListSelector> createState() => _FlatListSelectorState();
}

class _FlatListSelectorState extends State<FlatListSelector> {
  int selectedVehicleIndex = -1;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      selectedVehicleIndex = widget.vehicleTypes.indexWhere(
              (type) => type['label'] == widget.initialValue
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            widget.label,
            style: theme.textTheme.bodySmall
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.vehicleTypes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedVehicleIndex = index;
                  });
                  widget.onSelected(index);
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  width: 140,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedVehicleIndex == index ? theme.colorScheme.secondary : theme.colorScheme.surface,
                        width: 2,
                      ),
                      color: selectedVehicleIndex == index ? theme.colorScheme.secondary : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 3,
                          blurRadius: 10,
                          offset: Offset(0, 0),
                        ),
                      ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(widget.vehicleTypes[index]['icon'], width: 100),
                      Text(widget.vehicleTypes[index]['label'], style: theme.textTheme.bodySmall!.copyWith(
                          color: selectedVehicleIndex == index ? theme.colorScheme.surface : null
                      ),),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}