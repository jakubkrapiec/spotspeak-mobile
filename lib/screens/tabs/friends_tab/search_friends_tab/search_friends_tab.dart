import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/search_friends_tab/search_friends_bloc.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friend_tile.dart';
import 'package:spotspeak_mobile/screens/tabs/friends_tab/widgets/friends_search.dart';

class SearchFriendsTab extends StatefulWidget {
  const SearchFriendsTab({super.key});

  @override
  State<SearchFriendsTab> createState() => _SearchFriendsTabState();
}

class _SearchFriendsTabState extends State<SearchFriendsTab> {
  late final SearchFriendsBloc _bloc;
  late final TextEditingController _searchQueryController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<SearchFriendsBloc>();
    _searchQueryController = TextEditingController();
    _scrollController = ScrollController();
    _searchQueryController.addListener(_onQueryChanged);
  }

  @override
  void dispose() {
    _bloc.close();
    _searchQueryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onQueryChanged() {
    _bloc.add(ModifyQueryEvent(_searchQueryController.text));
  }

  void _retryAfterError() {
    _bloc.add(const RetryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchFriendsBloc, SearchFriendsState>(
      bloc: _bloc,
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async => _bloc.add(ModifyQueryEvent(_searchQueryController.text)),
          child: Scrollbar(
            controller: _scrollController,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                PinnedHeaderSliver(child: FriendsSearch(controller: _searchQueryController)),
                switch (state.status) {
                  LoadingStatus.error => SliverFillRemaining(
                      child: Center(child: LoadingError(onRetry: _retryAfterError)),
                    ),
                  LoadingStatus.loading => const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  LoadingStatus.loaded when state.users.isEmpty => SliverFillRemaining(
                      child: Center(child: Text('Brak wyników')),
                    ),
                  LoadingStatus.loaded => SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList.separated(
                        separatorBuilder: (context, index) => const Gap(8),
                        itemCount: state.users.length,
                        itemBuilder: (context, index) => FriendTile(
                          user: state.users[index],
                          onTap: () => context.router.push(UserProfileRoute(userId: state.users[index].id)),
                        ),
                      ),
                    ),
                },
              ],
            ),
          ),
        );
      },
    );
  }
}
