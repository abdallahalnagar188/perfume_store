import 'package:ecommerce_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_store/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce_store/features/personalization/models/address_model.dart';
import 'package:ecommerce_store/utils/constants/colors.dart';
import 'package:ecommerce_store/utils/constants/sizes.dart';
import 'package:ecommerce_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({super.key, required this.address, required this.onTap});

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(() {
      final selectedAddressId = controller.selectedAddress.value.id;
      final isSelected = selectedAddressId == address.id;

      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
        child: TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          width: double.infinity,
          showBorder: true,
          // Softer, more premium active state tint
          backgroundColor: isSelected
              ? TColors.primary.withOpacity(0.08)
              : Colors.transparent,
          borderColor: isSelected
              ? TColors.primary
              : (dark ? TColors.darkerGrey : TColors.grey.withOpacity(0.5)),
          margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header: Selection Indicator, Title & Action Buttons
              Row(
                children: [
                  // Active State Checkmark
                  if (isSelected) ...[
                    const Icon(Iconsax.tick_circle5, color: TColors.primary, size: 22),
                    const SizedBox(width: TSizes.sm),
                  ],
                  // Address Title
                  Expanded(
                    child: Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected ? TColors.primary : null,
                          ),
                    ),
                  ),
                  // Edit & Delete Actions aligned cleanly
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => controller.editAddressInit(address),
                        icon: const Icon(Iconsax.edit, size: 20),
                        color: TColors.darkGrey,
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Edit Address',
                      ),
                      IconButton(
                        onPressed: () => controller.deleteAddressPopup(address),
                        icon: const Icon(Iconsax.trash, size: 20),
                        color: TColors.error.withOpacity(0.8),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        tooltip: 'Delete Address',
                      ),
                    ],
                  )
                ],
              ),
              
              const SizedBox(height: TSizes.sm),
              const Divider(height: 1, thickness: 0.5),
              const SizedBox(height: TSizes.sm),

              // 2. Address Details
              _AddressDetailRow(
                icon: Iconsax.mobile,
                text: address.phoneNumber,
                context: context,
              ),
              const SizedBox(height: TSizes.sm / 2),
              
              _AddressDetailRow(
                icon: Iconsax.location,
                text: address.toString(),
                context: context,
                maxLines: 2,
              ),

              // 3. Optional GPS Coordinates
              if (address.latitude != null && address.longitude != null) ...[
                const SizedBox(height: TSizes.sm / 2),
                _AddressDetailRow(
                  icon: Iconsax.map_1,
                  text: 'Lat: ${address.latitude!.toStringAsFixed(4)}, Lng: ${address.longitude!.toStringAsFixed(4)}',
                  context: context,
                  isCaption: true,
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}

/// Helper widget to keep the main layout clean and prevent repetitive Row code
class _AddressDetailRow extends StatelessWidget {
  const _AddressDetailRow({
    required this.icon,
    required this.text,
    required this.context,
    this.maxLines = 1,
    this.isCaption = false,
  });

  final IconData icon;
  final String text;
  final BuildContext context;
  final int maxLines;
  final bool isCaption;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: maxLines > 1 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 18,
          color: isCaption ? TColors.darkGrey.withOpacity(0.7) : TColors.darkerGrey,
        ),
        const SizedBox(width: TSizes.md),
        Expanded(
          child: Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: isCaption
                ? Theme.of(context).textTheme.labelMedium?.copyWith(color: TColors.darkGrey)
                : Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}