import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../../../models/dummy/hhsrs_item.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/adaptive_layout_row_column.dart';
import '../../../utils/context_utils.dart';
import '../../../utils/enums.dart';
import '../../../utils/string_utils.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';
import '../../view_models/crud_view_model.dart';
import '../../widgets/app_custom_table.dart';
import '../../widgets/app_dropdown.dart';
import '../../widgets/app_expansion_tile.dart';
import '../../widgets/app_gradient_button.dart';
import '../new_crud_screen.dart';

class Crud extends StatelessWidget {
  static const String routeName = '/crud';
  const Crud({super.key});

  static const List<String> _attributes = [
    'Dwelling types',
    'Property Age Band',
    'Wall type',
    'Number of Storeys',
    'Number of bedrooms',
    'Primary Heating Fuel',
  ];
  static const List<HhsrsItem> _hhsrs = [
    HhsrsItem(
      name: 'Damp & Mould Growth',
      typicalRisk: true,
      dateAdded: 'Dec 03, 2022',
      status: true,
    ),
    HhsrsItem(
      name: 'Excess Cold',
      typicalRisk: true,
      dateAdded: 'Feb 19, 2023',
      status: true,
    ),
    HhsrsItem(
      name: 'Excess Heat',
      typicalRisk: true,
      dateAdded: 'Jan 29, 2020',
      status: true,
    ),
    HhsrsItem(
      name: 'Asbestos & MMF',
      typicalRisk: false,
      dateAdded: 'May 08, 2023',
      status: true,
    ),
    HhsrsItem(
      name: 'Biocides',
      typicalRisk: true,
      dateAdded: 'Aug 14, 2019',
      status: false,
    ),
    HhsrsItem(
      name: 'Carbon Monoxide',
      typicalRisk: true,
      dateAdded: 'Dec 14, 2022',
      status: true,
    ),
    HhsrsItem(
      name: 'Lead',
      typicalRisk: false,
      dateAdded: 'Jul 17, 2022',
      status: false,
    ),
    HhsrsItem(
      name: 'Radiation',
      typicalRisk: true,
      dateAdded: 'Nov 02, 2022',
      status: true,
    ),
    HhsrsItem(
      name: 'Uncombusted Fuel Gases',
      typicalRisk: true,
      dateAdded: 'Oct 01, 2023',
      status: true,
    ),
    HhsrsItem(
      name: 'Volatile Organic Compounds',
      typicalRisk: true,
      dateAdded: 'Oct 01, 2023',
      status: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CrudViewModel>(
      builder: (context, viewModel, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 12.w,
              runSpacing: 12.sp,
              children: List.generate(CrudType.values.length, (index) {
                final type = CrudType.values[index];
                final bool isSelected = viewModel.crudType == type;
                return ChoiceChip(
                  selected: isSelected,
                  onSelected: (_) {
                    viewModel.setCrudType(type);
                  },
                  showCheckmark: false,
                  backgroundColor: isSelected ? null : AppColors.white,
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.primaryLight
                        : AppColors.lightGrey1,
                  ),
                  label: Text(
                    type.label,
                    style: isSelected
                        ? AppFonts.primaryDark16w500
                        : AppFonts.black16w600,
                  ),
                );
              }),
            ),
            SizedBox(height: 20.sp),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    spacing: 16.sp,
                    children: [
                    AdaptiveLayoutRowColumn(
                        heightBetween: 6,
                        children: [
                          SizedBox(
                            width: context.isLandscape ? 260.w : double.infinity,
                            child: const CupertinoSearchTextField(),
                          ),
                          context.isLandscape
                              ? const Spacer()
                              : const SizedBox.shrink(),
                          if (context.isLandscape)
                            AppDropdown<InspectionStatus>(
                              items: InspectionStatus.values,
                              builder: (item) => Text(
                                item.name.capitalize,
                                style: AppFonts.black14w400,
                              ),
                              hint: 'Status',
                              onChanged: (value) {},
                            )
                          else
                            Row(
                              children: [
                                Expanded(
                                  child: AppDropdown<InspectionStatus>(
                                    items: InspectionStatus.values,
                                    builder: (item) => Text(
                                      item.name.capitalize,
                                      style: AppFonts.black14w400,
                                    ),
                                    hint: 'Status',
                                    onChanged: (value) {},
                                  ),
                                ),
                              ],
                            ),

                          AppGradientButton(
                            title: 'Add New',
                            icon: TablerIcons.plus,
                            onTap: () => NewCrudScreen.show(
                              context: AppRoutes.navigatorKey.currentContext!,
                            ),
                          ),
                        ],
                      ),  Expanded(
                        child: SingleChildScrollView(
                          child: switch (viewModel.crudType) {
                            CrudType.stock => _buildStockView(),
                            CrudType.attributes => _buildAttributesView(),
                            CrudType.hhsrs => _buildHhSrsView(),
                            CrudType.sorCodes => _buildSorCodesView(),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Column _buildStockView() {
    return Column(
      spacing: 16.sp,
      children: [
        AppExpansionTile(
          title: 'Externals',
          actions: [
            IconButton(
              iconSize: 16.sp,
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.pencil),
            ),
            IconButton(
              iconSize: 16.sp,
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.trash, color: AppColors.red),
            ),
          ],
        ),
        AppExpansionTile(
          title: 'Internals',
          actions: [
            IconButton(
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              iconSize: 16.sp,
              icon: const Icon(TablerIcons.pencil),
            ),
            IconButton(
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              iconSize: 16.sp,
              icon: const Icon(TablerIcons.trash, color: AppColors.red),
            ),
          ],
        ),
        AppExpansionTile(
          title: 'Energy',
          actions: [
            IconButton(
              onPressed: () {},
              iconSize: 16.sp,
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.pencil),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 16.sp,
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.trash, color: AppColors.red),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildAttributesView() {
    return Column(
      spacing: 16.sp,
      children: _attributes.map((attribute) {
        return AppExpansionTile(
          title: attribute,
          actions: [
            IconButton(
              onPressed: () {},
              iconSize: 16.sp,
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.pencil),
            ),
            IconButton(
              onPressed: () {},
              iconSize: 16.sp,
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.trash, color: AppColors.red),
            ),
          ],
        );
      }).toList(),
    );
  }

  Column _buildHhSrsView() {
    return Column(
      spacing: 16.sp,
      children: [
        AppExpansionTile(
          title: 'Housing Health and Safety Rating System',
          actions: [
            IconButton(
              iconSize: 16.sp,
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.pencil),
            ),
            IconButton(
              iconSize: 16.sp,
              onPressed: () {},
              visualDensity: VisualDensity.compact,
              icon: const Icon(TablerIcons.trash, color: AppColors.red),
            ),
          ],
          child: AppCustomTable(
            columns: const [
              'Item Name',
              'Typical Risk',
              'Date Added',
              'Status',
              '',
            ],
            rows: List.generate(_hhsrs.length, (index) {
              final item = _hhsrs[index];
              return <Widget>[
                Text(item.name, style: AppFonts.black14w400),
                Text(
                  item.typicalRisk ? 'Yes' : 'No',
                  style: item.typicalRisk
                      ? AppFonts.green14w400
                      : AppFonts.red14w400,
                ),
                Text(item.dateAdded, style: AppFonts.black14w400),
                Switch(
                  value: item.status,
                  onChanged: (value) {},
                  activeTrackColor: AppColors.green,
                  trackOutlineColor: WidgetStatePropertyAll(
                    item.status ? AppColors.green : AppColors.lightGrey1,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(TablerIcons.dots, size: 16.sp),
                ),
              ];
            }).toList(),
            flexValues: [275.w, 275.w, 275.w, 130.w, 70.w],
          ),
        ),
      ],
    );
  }

  AppCustomTable _buildSorCodesView() {
    return AppCustomTable(
      columns: const [
        'Document Code',
        'New v7.2',
        'Priority',
        'Right to Repair',
        'Component Accounting',
        'First Time Fix',
        'NHF_Trade_Code',
        'Short Description',
        'Element',
        'Section',
        'Subsection',
        'UOM',
        'SOR Rate',
        'Long Description',
      ],
      rows: List.generate(12, (index) {
        return [
          Text('323909', style: AppFonts.black14w400),
          index % 5 == 0
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.sp),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlue,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text('New', style: AppFonts.blue14w400),
                )
              : const SizedBox.shrink(),
          Text(index % 3 == 0 ? 'X' : 'R', style: AppFonts.black14w400),
          Text(
            index % 4 == 0 ? 'Y' : 'N',
            style: index % 4 == 0 ? AppFonts.green14w400 : AppFonts.red14w400,
          ),
          Text(
            index % 4 == 0 ? 'Y' : 'N',
            style: index % 4 == 0 ? AppFonts.green14w400 : AppFonts.red14w400,
          ),
          Text(
            index % 4 == 0 ? 'Y' : 'N',
            style: index % 4 == 0 ? AppFonts.green14w400 : AppFonts.red14w400,
          ),
          Text('JR', style: AppFonts.black14w400),
          Text(
            'ENT FIRE DOORSET:RENEW 2 GLAZED FD30 FAN&SIDELIGHT',
            style: AppFonts.black14w400,
          ),
          Text('Carpentry and Joinery', style: AppFonts.black14w400),
          Text('External Doors', style: AppFonts.black14w400),
          Text(
            'Entrance Fire Doorsets - Glazed 2 Panel',
            style: AppFonts.black14w400,
          ),
          Text('IT', style: AppFonts.black14w400),
          Text('\$3,170.978', style: AppFonts.black14w400),
          Text(
            'Entrance Fire Doorset:Renew existing door and frame with standard size Gerda Security or equal and approved self-finished engineered FD30 glazed door style G2 (two glass panel) doorset [30SHR – G2], door glazed with two fire multishield P1A EV multidirectional laminated double glazed units certified to EN356 P1A glazed panel, with hardwood frame and two panel (upper glazed, lower solid) sidelight and glazed fanlight, complete with cill if required, doorset tested to EN1634-1 for fire and to EN1634 – 3 for smoke, to BS6375/1, 2 and 3 for weathering and durability, doorset to ENISO 10071 for thermal insulation, doorset to PAS24 for security and Secure by design, all to BMTRADA, laminated double glazed unit certified to EN356 P1A fanlight and upper sidelight panel, lower solid sidelight panel, stainless steel hinges, seals, surface mounted cam action door closer, smooth action multipoint locking system with handle set to external and thumbturn to internal face, fire rated satin chrome letterplate, satin chrome door chain or door limiter, door viewer and numerals, and door knocker, take out existing door and frame, fit new doorset in accordance with manufacturer\'s technical data sheet, independent installation inspection, make good and remove waste and debris.',
            style: AppFonts.black14w400,
          ),
        ];
      }),
      fixedSpan: true,
      flexValues: [
        190.w,
        80.w,
        100.w,
        120.w,
        120.w,
        120.w,
        160.w,
        260.w,
        140.w,
        190.w,
        190.w,
        80.w,
        120.w,
        470.w,
      ],
      rowHeight: 56.sp,
    );
  }
}
