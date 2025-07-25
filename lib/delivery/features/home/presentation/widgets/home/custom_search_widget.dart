import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:x_go/core/common/widgets/custom_text_form_field.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_loggr.dart';
import 'package:x_go/delivery/features/home/domain/entities/accepted_order_entity.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_order_state.dart';
import 'package:x_go/delivery/features/home/presentation/logic/new_order_cubit/new_status_cubit.dart';
import 'package:x_go/delivery/features/home/presentation/widgets/custom_order_card.dart';

class CustomSearchDeliveryApp extends StatefulWidget {
  const CustomSearchDeliveryApp({super.key});

  @override
  State<CustomSearchDeliveryApp> createState() =>
      _CustomSearchDeliveryAppState();
}

class _CustomSearchDeliveryAppState extends State<CustomSearchDeliveryApp> {
  final TextEditingController? _searchController = TextEditingController();

  List<OrderStatusEntity> _orders = <OrderStatusEntity>[];
  List<OrderStatusEntity> _filteredOrders = <OrderStatusEntity>[];

  @override
  void didChangeDependencies() {
    if (_orders.isEmpty) AppLogger.d('Orders list is empty');
    if (_filteredOrders.isEmpty) AppLogger.d('Filtered orders list is empty');
    AppLogger.d(_orders);
    AppLogger.d(_filteredOrders);
    super.didChangeDependencies();
  }

  void initState() {
    super.initState();
    _orders = context.read<NewOrdersCubit>().allOrders;
    _filteredOrders = _orders;
  }

  @override
  void dispose() {
    _searchController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Orders'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppColors.primaryColor,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0.w),
        child: Column(
          children: [
            CustomTextFormField(
              verticalPadding: 14.0.w,
              hintText: 'Search...',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a search term';
                }
                return null;
              },
              controller: _searchController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              fillColor: AppColors.white,
              prefixIcon: Icon(Icons.search, color: AppColors.grey),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: AppColors.grey),
                onPressed: () {
                  _searchController?.clear();
                  setState(() {
                    _filteredOrders = _orders;
                  });
                },
              ),
              onFieldSubmitted: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _filteredOrders = _orders;
                  } else {
                    _filteredOrders = _orders
                        .where((order) => order.id.toString().contains(value))
                        .toList();
                  }
                });
              },
              onchanged: (value) {
                setState(() {
                  if (value.isEmpty) {
                    _filteredOrders = _orders;
                  } else {
                    _filteredOrders = _orders
                        .where((order) => order.id.toString().contains(value))
                        .toList();
                  }
                });
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<NewOrdersCubit, NewOrderStatusState>(
                builder: (context, state) {
                  return state.when(
                    initial: () =>
                        const Center(child: Text('No orders available')),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    success: (orders) {
                      final filtered =
                          _searchController?.text.isNotEmpty == true
                          ? orders
                                .where(
                                  (order) => order.id.toString().contains(
                                    _searchController!.text,
                                  ),
                                )
                                .toList()
                          : orders;
                      if (orders.isEmpty) {
                        return const Center(child: Text('No orders available'));
                      } else if ((_searchController?.text.isNotEmpty ??
                              false) &&
                          filtered.isEmpty) {
                        return const Center(child: Text('No orders found'));
                      } else {
                        return ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final order = filtered[index];
                            return OrderCard(
                              order: order,
                              statusColor: AppColors.primaryColor,
                            );
                          },
                        );
                      }
                    },
                    error: (msg) => Center(child: Text(msg)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
