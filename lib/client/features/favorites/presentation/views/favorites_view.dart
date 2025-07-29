import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:x_go/core/functions/show_toast.dart';
import 'package:x_go/core/routes/router_names.dart';
import 'package:x_go/core/theme/app_colors.dart';
import 'package:x_go/core/utils/app_loggr.dart';
import 'package:x_go/core/utils/app_strings.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_cubit.dart';
import 'package:x_go/client/features/favorites/presentation/logic/cubit/favorites_state.dart';
import 'package:x_go/client/features/favorites/presentation/widgets/favorite_car_item.dart';
import 'package:x_go/client/features/language/presentation/widgets/instant_language_builder.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    context.read<FavoritesCubit>().getFavorites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RealTimeLanguageBuilder(
      builder: (context, locale) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppStrings.favorites.tr(),
              style: TextStyle(fontSize: 20.sp, color: AppColors.primaryColor),
            ),
            centerTitle: true,
          ),
          body: BlocBuilder<FavoritesCubit, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
              } else if (state is FavoritesLoaded) {
                if (state.favorites.isEmpty) {
                  return Center(
                    child: Text(
                      AppStrings.noFavoriteCarsYet.tr(),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.favorites.length,
                  itemBuilder: (context, index) {
                    final favorite = state.favorites[index];
                    return FavoriteCarItem(
                      favorite: favorite,
                      onToggleFavorite: () {
                        context.read<FavoritesCubit>().toggleFavorite(
                          favorite.carModel.id,
                        );
                        // Show toast message when car is removed from favorites
                        showToast(
                          message: AppStrings.carRemovedFromFavorites.tr(),
                          state: ToastStates.WARNING,
                        );
                      },
                      onTap: () {
                        // Navigate to car details when the item is tapped
                        context.pushNamed(
                          RouterNames.carDetails,
                          extra: favorite.carModel.id,
                        );
                      },
                    );
                  },
                );
              } else if (state is FavoritesError) {
                return Center(
                  child: Text(
                    state.message,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        );
      },
    );
  }
}
