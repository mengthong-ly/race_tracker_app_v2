part of 'race_view.dart';

class _RaceAdaptive extends StatelessWidget {
  const _RaceAdaptive({required this.viewModel});
  final RaceViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Race?>(
      future: viewModel.init(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: RColor.primary,
              ),
            ),
          );
        } else {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              bottomSheet: Container(
                width: MediaQuery.of(context).size.width,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    )
                  ],
                  color: RColor.white,
                ),
                child: viewModel.isRaceStarted
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: RColor.error,
                        ),
                        onPressed: viewModel.stopRace,
                        child: Text(
                          'End',
                          style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
                            color: RColor.white,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: RColor.primary,
                        ),
                        onPressed: viewModel.startRace,
                        child: Text(
                          'Start',
                          style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
                            color: RColor.white,
                          ),
                        ),
                      ),
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      bottom: buildTabBar(),
                      leading: const SizedBox.shrink(),
                      foregroundColor: RColor.black,
                      leadingWidth: 0,
                      title: RaceTimerDisplay(
                          viewModel: viewModel, context: context),
                      floating: true,
                      centerTitle: false,
                      toolbarHeight: 180,
                    )
                  ];
                },
                body: TabBarView(
                  children: [
                    buildSwimmingScrollView(
                        participants: viewModel.sortedParticipantsForDisplay(
                            snapshot.data!.participants),
                        segment: snapshot.data!.segments[0]),
                    buildCyclingScrollView(
                        participants: viewModel.sortedParticipantsForDisplay(
                            snapshot.data!.participants),
                        segment: snapshot.data!.segments[1]),
                    buildRunningScrollView(
                        participants: viewModel.sortedParticipantsForDisplay(
                            snapshot.data!.participants),
                        segment: snapshot.data!.segments[2])
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  PreferredSize buildTabBar() {
    return const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TabBar(
            splashFactory: NoSplash.splashFactory,
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            splashBorderRadius: BorderRadius.all(Radius.circular(0)),
            indicatorColor: RColor.primary,
            labelColor: RColor.primary,
            tabs: [
              Tab(
                text: 'Swimming',
              ),
              Tab(
                text: 'Cycling',
              ),
              Tab(
                text: 'Running',
              ),
            ]));
  }

  Widget buildSwimmingScrollView(
      {required List<Participant> participants, required Segment segment}) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ParticipantSelectionTile(
                  segmentEndTime: participants[index].swimmingSegment?.endTime,
                  isSelectable: viewModel.isRaceStarted,
                  segment: segment,
                  participant: participants[index],
                  index: index,
                );
              },
              childCount:
                  participants.length, // Set your desired number of items
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 150,
          ),
        )
      ],
    );
  }

  Widget buildCyclingScrollView(
      {required List<Participant> participants, required Segment segment}) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ParticipantSelectionTile(
                  segmentEndTime: participants[index].cyclingSegment?.endTime,
                  isSelectable: viewModel.isRaceStarted &&
                      participants[index].swimmingSegment != null,
                  segment: segment,
                  participant: participants[index],
                  index: index,
                );
              },
              childCount:
                  participants.length, // Set your desired number of items
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 150,
          ),
        )
      ],
    );
  }

  Widget buildRunningScrollView(
      {required List<Participant> participants, required Segment segment}) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ParticipantSelectionTile(
                  segmentEndTime: participants[index].runningSegment?.endTime,
                  isSelectable: viewModel.isRaceStarted &&
                      participants[index].swimmingSegment != null &&
                      participants[index].cyclingSegment != null,
                  segment: segment,
                  participant: participants[index],
                  index: index,
                );
              },
              childCount:
                  participants.length, // Set your desired number of items
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 150,
          ),
        )
      ],
    );
  }
}
