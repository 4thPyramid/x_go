import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_order_state.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_empty_state_widget.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_error_state_widget.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_order_card.dart';

class NewRequestOrderTab extends StatelessWidget {
  const NewRequestOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewOrdersCubit, NewOrderStatusState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () => context.read<NewOrdersCubit>().fetchNewOrders(),
          child: state.when(
            initial: () => EmptyStateWidget(
              message: 'No orders yet',
              icon: Icons.local_taxi_outlined,
              onRefresh: () => context.read<NewOrdersCubit>().fetchNewOrders(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (message) => ErrorStateWidget(
              message: message,
              onRetry: () => context.read<NewOrdersCubit>().fetchNewOrders(),
            ),
            success: (newOrders) {
              if (newOrders.isEmpty) {
                return EmptyStateWidget(
                  message: 'No newOrders orders available',
                  icon: Icons.assignment_outlined,
                  onRefresh: () =>
                      context.read<NewOrdersCubit>().fetchNewOrders(),
                );
              }
              return ListView.builder(
                itemCount: newOrders.length,
                itemBuilder: (context, index) {
                  final order = newOrders[index];
                  return OrderCard(
                    order: order,
                    statusText: 'Assigned',
                    statusColor: Color.fromARGB(255, 128, 137, 190),
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
