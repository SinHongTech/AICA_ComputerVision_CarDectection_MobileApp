import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

import '../l10n/l10n_context.dart';
import '../l10n/demo_labels.dart';

import '../data/demo_data.dart';
import 'vehicle_detail_screen.dart';
import 'widgets/app_components.dart';

class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  void _addVehicle(BuildContext context) {
    showMobileBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        String type = 'Car';
        String plate = '';
        return StatefulBuilder(
          builder: (context, setSheetState) => Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              12,
              20,
              MediaQuery.viewInsetsOf(context).bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.addAVehicle,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaInk(context),
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        avatar: Icon(
                          Icons.directions_car_outlined,
                          color: aicaBlue(context),
                        ),
                        label: Text(context.l10n.car),
                        selected: type == 'Car',
                        onSelected: (_) => setSheetState(() => type = 'Car'),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ChoiceChip(
                        avatar: Icon(
                          Icons.two_wheeler,
                          color: aicaBlue(context),
                        ),
                        label: Text(context.l10n.motorcycle),
                        selected: type == 'Motorcycle',
                        onSelected: (_) =>
                            setSheetState(() => type = 'Motorcycle'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  context.l10n.plateNumber,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaInk(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7),
                TextField(
                  textCapitalization: TextCapitalization.characters,
                  onChanged: (value) => plate = value,
                  decoration: InputDecoration(
                    hintText: '2AB-1234',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  context.l10n.officialRegistryVerificationIsNotConnectedIn,
                  style: TextStyle(
                    fontFamily: aicaFontFamily,
                    fontFamilyFallback: khmerFontFallback,
                    color: aicaMuted(context),
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 18),
                FilledButton(
                  onPressed: () {
                    final trimmed = plate.trim();
                    if (trimmed.isEmpty) {
                      showDemoMessage(context, context.l10n.enterAPlateNumber);
                      return;
                    }
                    showDemoMessage(
                      context,
                      context.l10n.vehicleVerificationPendingFor(
                        trimmed.toUpperCase(),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text(context.l10n.submitForVerification),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => DetailPage(
    title: context.l10n.myVehiclesLabel,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 12),
        child: FilledButton.tonalIcon(
          onPressed: () => _addVehicle(context),
          icon: Icon(Icons.add, size: 20),
          label: Text(context.l10n.add),
          style: FilledButton.styleFrom(
            minimumSize: Size(0, 40),
            padding: EdgeInsets.symmetric(horizontal: 14),
            textStyle: TextStyle(
              fontFamily: aicaFontFamily,
              fontFamilyFallback: khmerFontFallback,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    ],
    child: Column(
      children: [
        for (final vehicle in demoVehicles) ...[
          InkWell(
            onTap: () =>
                openPage(context, VehicleDetailScreen(vehicle: vehicle)),
            child: AppPanel(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: aicaTone(context, Color(0xFFEAF1FF)),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          vehicle.type == 'Car'
                              ? Icons.directions_car
                              : Icons.two_wheeler,
                          color: aicaBlue(context),
                          size: 26,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              vehicle.name,
                              style: TextStyle(
                                fontFamily: aicaFontFamily,
                                fontFamilyFallback: khmerFontFallback,
                                color: aicaInk(context),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              vehicleTypeLabel(context, vehicle.type),
                              style: TextStyle(
                                fontFamily: aicaFontFamily,
                                fontFamilyFallback: khmerFontFallback,
                                color: aicaMuted(context),
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, color: aicaMuted(context)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: aicaInk(context),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'CAMBODIA · ព្រះរាជាណាចក្រកម្ពុជា',
                                  style: TextStyle(
                                    fontFamily: aicaFontFamily,
                                    fontFamilyFallback: khmerFontFallback,
                                    color: aicaBlue(context),
                                    fontSize: 6,
                                  ),
                                ),
                                Text(
                                  vehicle.plate,
                                  style: TextStyle(
                                    fontFamily: aicaFontFamily,
                                    fontFamilyFallback: khmerFontFallback,
                                    color: aicaInk(context),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: aicaTone(context, Color(0xFFE5F6EB)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          context.l10n.verifiedLabel,
                          style: TextStyle(
                            fontFamily: aicaFontFamily,
                            fontFamilyFallback: khmerFontFallback,
                            color: aicaTone(context, Color(0xFF188653)),
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
        ],
      ],
    ),
  );
}
