import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/delivery/features/home/presentation/logic/completed_status_cubit/completed_order_state.dart';
import 'package:x_go/delivery/features/home/presentation/logic/completed_status_cubit/completed_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_empty_state_widget.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_error_state_widget.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_order_card.dart';

class CompletedOrderTab extends StatelessWidget {
  const CompletedOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompletedOrdersCubit, CompletedOrderStatusState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () =>
              context.read<CompletedOrdersCubit>().fetchCompletedOrders(),
          child: state.maybeWhen(
            initial: () => EmptyStateWidget(
              message: 'No orders yet',
              icon: Icons.local_taxi_outlined,
              onRefresh: () =>
                  context.read<CompletedOrdersCubit>().fetchCompletedOrders(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => ErrorStateWidget(
              message: message,
              onRetry: () =>
                  context.read<CompletedOrdersCubit>().fetchCompletedOrders(),
            ),
            success: (orders) {
              if (orders.isEmpty) {
                return EmptyStateWidget(
                  message: 'No Completed orders available',
                  icon: Icons.assignment_outlined,
                  onRefresh: () => context
                      .read<CompletedOrdersCubit>()
                      .fetchCompletedOrders(),
                );
              }
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return OrderCard(
                    order: order,
                    statusColor: AppColors.black,
                    statusText: 'Completed',
                  );
                },
              );
            },
            orElse: () {
              return const Center(child: Text('Unexpected state'));
            },
          ),
        );
      },
    );
  }
}
