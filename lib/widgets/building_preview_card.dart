import 'package:flutter/material.dart';
import '../models/building.dart';

class BuildingPreviewCard extends StatelessWidget {
  final CampusBuilding building;
  final VoidCallback? onTap;
  final Widget? action;
  final bool showSubtitle;

  const BuildingPreviewCard({
    super.key,
    required this.building,
    this.onTap,
    this.action,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = building.imagePath?.isNotEmpty == true;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (hasImage) ...[
                  Hero(
                    tag: building.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        building.imagePath!,
                        width: 84,
                        height: 84,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                ],
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          building.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (showSubtitle) ...[
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withAlpha(
                                (theme.colorScheme.primary.a * 255.0 * 0.12)
                                    .round(),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              building.category,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          building.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (action != null) ...[
                  const SizedBox(width: 12),
                  action!,
                ] else if (onTap != null) ...[
                  const SizedBox(width: 12),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
