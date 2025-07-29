import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/client/features/Details/presentation/logic/cubit/car_detail_cubit.dart';
import 'package:x_go/core/app_cubit/guest_mode/enums.dart';
import 'package:x_go/core/app_cubit/guest_mode/session_cubit.dart';
import 'package:x_go/core/common/widgets/custom_btn.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/client/features/Details/presentation/logic/cubit/car_detail_state.dart';
import 'package:x_go/core/utils/image_url_helper.dart';
import 'package:x_go/client/features/Details/presentation/widgets/booking_button.dart';
import 'package:x_go/client/features/Details/presentation/widgets/car_detail_info_cards.dart';
import 'package:x_go/client/features/home/domain/entity/car_entity.dart';

class CarDetailsPage extends StatefulWidget {
  final String? carId;

  const CarDetailsPage({super.key, this.carId});

  @override
  State<CarDetailsPage> createState() => _CarDetailsPageState();
}

class _CarDetailsPageState extends State<CarDetailsPage> {
  @override
  void initState() {
    super.initState();
    if (widget.carId != null) {
      // Use a post-frame callback to ensure the widget is fully built
      // before accessing the provider
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context.read<CarDetailCubit>().getCarDetail(widget.carId!);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/logo.png', height: 40.h),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: widget.carId != null ? _buildDetailView() : Container(),
    );
  }

  Widget _buildDetailView() {
    return BlocBuilder<CarDetailCubit, CarDetailState>(
      builder: (context, state) {
        if (state is CarDetailLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CarDetailError) {
          return Center(child: Text(state.message));
        } else if (state is CarDetailLoaded) {
          final carDetail = state.carDetail.data;
          final attributes = carDetail.attributes;
          final relationship = carDetail.relationship;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Image Gallery
                SizedBox(
                  height: 220.h,
                  child: relationship.images.isEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: CachedNetworkImage(
                              imageUrl: ImageUrlHelper.normalizeImageUrl(
                                attributes.image,
                              ),
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) {
                                ImageUrlHelper.logImageError(url, error);
                                return Text(
                                  'No Image Available',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.grey[600],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: relationship.images.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: CachedNetworkImage(
                                  imageUrl: ImageUrlHelper.normalizeImageUrl(
                                    relationship.images[index],
                                  ),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                  errorWidget: (context, url, error) {
                                    ImageUrlHelper.logImageError(url, error);
                                    return Image.asset(
                                      'assets/images/Group 7.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand and Model info
                      Text(
                        relationship.brand.name,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        relationship.modelName.name,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          SizedBox(width: 4.w),
                          Text(
                            relationship.type.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15.h),
                      Text(
                        'Car Details',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      CarDetailInfoCards(attributes: attributes),

                      SizedBox(height: 18.h),

                      SizedBox(height: 18.h),
                      // Price section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Price',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '\$${attributes.price} / day',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: BookingButton(
                          car: CarEntity(
                            id: carDetail.id,
                            modelName: relationship.modelName.name,
                            year: attributes.year,
                            price: attributes.price,
                            engineType: attributes.engineType,
                            transmissionType: attributes.transmissionType,
                            seatType: attributes.seatType,
                            seatsCount: attributes.seatsCount,
                            acceleration: attributes.acceleration,
                            image: attributes.image,
                            typeName: relationship.type.name,
                            brandName: relationship.brand.name,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Center(
                        child: CustomButton(
                          text: 'Add Review',
                          onPressed: () {
                            final isGuest =
                                context.read<SessionCubit>().state.status ==
                                AuthStatus.guest;

                            if (isGuest) {
                              showToast(
                                message: 'Please log in to add a review',
                                state: ToastStates.ERROR,
                              );
                              return;
                            }

                            context.push(
                              RouterNames.review,
                              extra: widget.carId,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('No data available'));
      },
    );
  }
}
