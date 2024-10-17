import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gps_tracker/domain/entities/attributes.dart';
import 'package:gps_tracker/domain/entities/command.dart';
import 'package:gps_tracker/domain/entities/device.dart';
import 'package:gps_tracker/presentation/extensions/build_context_extension.dart';
import 'package:gps_tracker/presentation/misc/colors.dart';
import 'package:gps_tracker/presentation/misc/screen.dart';
import 'package:gps_tracker/presentation/misc/typography.dart';
import 'package:gps_tracker/presentation/providers/api/device_command_provider.dart';
import 'package:gps_tracker/presentation/providers/api/saved_commands_provider.dart';
import 'package:gps_tracker/presentation/widgets/button/custom_button.dart';
import 'package:gps_tracker/presentation/widgets/dialog/loading_dialog.dart';
import 'package:gps_tracker/presentation/widgets/dropdown/ug_command_dropdown.dart';
import 'package:gps_tracker/presentation/widgets/dropdown/ug_command_type_dropdown.dart';
import 'package:gps_tracker/presentation/widgets/text_field/ug_command_text_field.dart';

class DeviceCommandPage extends ConsumerStatefulWidget {
  final Device device;
  const DeviceCommandPage({super.key, required this.device});

  @override
  ConsumerState<DeviceCommandPage> createState() => _DevicePageState();
}

class _DevicePageState extends ConsumerState<DeviceCommandPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<DropdownSearchState> _dropdownSavedCmdKey = GlobalKey<DropdownSearchState>();
  final GlobalKey<DropdownSearchState> _dropdownCmdTypeKey = GlobalKey<DropdownSearchState>();

  final TextEditingController _indexController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  Command? _selectedCommand;
  CommandType? _selectedType;

  List<CommandType> commandTypes = [
    CommandType(text: "Engine Stop", value: "engineStop"),
    CommandType(text: "Command Custom", value: "custom"),
    CommandType(text: "Output Control", value: "outputControl"),
    CommandType(text: "Engine Resume", value: "engineResume"),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(savedCommandsProvider.notifier).getSavedCommands(deviceId: widget.device.id);
    });
  }

  @override
  void dispose() {
    _indexController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  void _clearData() {
    _selectedCommand = null;
    _selectedType = null;
    _indexController.clear();
    _dataController.clear();
    _dropdownSavedCmdKey.currentState?.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      deviceCommandProvider,
      (previous, next) {
        next.when(
          data: (data) {
            hideLoadingDialog(context);
            if (data != null) {
              context.showSnackBar("Success send command to ${widget.device.name}");
              _clearData();
            }
          },
          error: (error, stackTrace) {
            hideLoadingDialog(context);
            context.showSnackBar(error.toString());
          },
          loading: () {
            showLoadingDialog(context);
          },
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.device.name,
          style: Typogaphy.Medium.copyWith(
            fontSize: 16,
          ),
        ),
      ),
      body: ListView(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.dark,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        UgCommandDropdown(
                          dropdownKey: _dropdownSavedCmdKey,
                          label: "Saved Commands",
                          selectedCommand: _selectedCommand,
                          commandItems: ref.watch(savedCommandsProvider).when(
                                data: (data) => [
                                  Command(id: 0, deviceId: widget.device.id, description: "New..."),
                                  ...data,
                                ],
                                error: (error, stackTrace) => [],
                                loading: () => [],
                              ),
                          onChanged: (command) {
                            _selectedCommand = command;
                            if (command?.id == 0) {
                              _selectedType = null;
                              _indexController.clear();
                              _dataController.clear();
                            }
                            setState(() {});
                          },
                        ),
                        if ((_dropdownSavedCmdKey.currentState?.getSelectedItem as Command?)?.id == 0)
                          Column(
                            children: [
                              const SizedBox(height: 16),
                              UgCommandTypeDropdown(
                                dropdownKey: _dropdownCmdTypeKey,
                                label: "Type",
                                selectedItem: _selectedType,
                                items: commandTypes,
                                onChanged: (value) {
                                  _indexController.clear();
                                  _dataController.clear();
                                  _selectedType = value;
                                  setState(() {});
                                },
                              ),
                              if (_selectedType?.value == "outputControl" || _selectedType?.value == "custom")
                                const SizedBox(height: 16),
                              if (_selectedType?.value == "outputControl")
                                UgCommandTextField(
                                  controller: _indexController,
                                  label: "Index",
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                ),
                              if (_selectedType?.value == "outputControl") const SizedBox(height: 16),
                              if (_selectedType?.value == "custom" || _selectedType?.value == "outputControl")
                                UgCommandTextField(
                                  controller: _dataController,
                                  label: "Data",
                                  textInputAction: TextInputAction.go,
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: AppScreens.width * 0.30,
                        child: CustomButton(
                          color: AppColors.primarySoft,
                          title: "Cancel",
                          onPressed: () {
                            _clearData();
                          },
                        ),
                      ),
                      SizedBox(
                        width: AppScreens.width * 0.30,
                        child: CustomButton(
                          title: "Send",
                          onPressed: () {
                            Command? commandData;
                            if ((_dropdownSavedCmdKey.currentState?.getSelectedItem as Command).id == 0) {
                              // Membuat objek Attributes baru dengan nilai dari text controller
                              Attributes newAttributes = Attributes(
                                index: (_indexController.text.isNotEmpty) ? int.parse(_indexController.text) : null,
                                data: (_dataController.text.isNotEmpty) ? _dataController.text : null,
                              );

                              commandData = _selectedCommand?.copyWith(
                                type: _selectedType?.value,
                                attributes: newAttributes,
                              );
                            } else {
                              commandData = _selectedCommand;
                            }
                            if (commandData != null) {
                              Command data = commandData.copyWith(deviceId: widget.device.id);
                              ref.read(deviceCommandProvider.notifier).sendCommand(command: data);
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
