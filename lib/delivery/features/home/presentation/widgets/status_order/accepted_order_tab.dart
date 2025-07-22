// accepted_order_tab.dart
// This widget displays the accepted orders tab with pull-to-refresh functionality.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/home/presentation/logic/accepted_status_cubit/oreder_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/logic/accepted_status_cubit/accepted_order_state.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_error_state_widget.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_empty_state_widget.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_order_card.dart';

class AcceptedOrderTab extends StatelessWidget {
  const AcceptedOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcceptedOrdersCubit, AcceptedStatusState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () =>
              context.read<AcceptedOrdersCubit>().fetchAcceptedOrders(),
          child: state.when(
            acceptedOrderInitial: () => EmptyStateWidget(
              message: 'No orders yet',
              icon: Icons.local_taxi_outlined,
              onRefresh: () =>
                  context.read<AcceptedOrdersCubit>().fetchAcceptedOrders(),
            ),
            acceptedOrderLoading: () =>
                const Center(child: CircularProgressIndicator()),
            acceptedError: (message) => ErrorStateWidget(
              message: message,
              onRetry: () =>
                  context.read<AcceptedOrdersCubit>().fetchAcceptedOrders(),
            ),
            acceptedOrderSuccess: (orders) {
              if (orders.isEmpty) {
                return EmptyStateWidget(
                  message: 'No accepted orders available',
                  icon: Icons.assignment_outlined,
                  onRefresh: () =>
                      context.read<AcceptedOrdersCubit>().fetchAcceptedOrders(),
                );
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderCard(
                    order: order,
                    statusColor: AppColors.success,
                    statusText: 'Accepted',
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
