part of 'dashboard_view.dart';

class _DashboardAdaptive extends StatelessWidget {
  const _DashboardAdaptive({required this.viewModel});
  final DashboardViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final Race? race = viewModel.race?.status == Status.active
        ? viewModel.race
        : viewModel.latestHistory;
    if (race == null) {
      // No race in progress and no history
      return Scaffold(
        body: Center(
          child: Text(
            "No race data available.",
            style: TTextTheme.darkTextTheme.titleLarge,
          ),
        ),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [];
        },
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    TVerticalSpacing.xxl,
                    Text(race.name ?? '--' ,
                        style: TTextTheme.darkTextTheme.bodyMedium),
                    Text(
                      race.status.label,
                      style: TTextTheme.darkTextTheme.titleLarge!.copyWith(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: RColor.primary),
                    ),
                    TVerticalSpacing.l,
                    buildRaceInfo(context, race),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.only(top: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: RColor.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: RColor.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DataRow(
                            title: "${race.participants.length }",
                            description: "Participants",
                          ),
                          THorizontalSpacing.m,
                          SizedBox(
                            height: 60,
                            child: VerticalDivider(
                              color: RColor.black.withOpacity(0.5),
                              thickness: 0.5,
                            ),
                          ),
                          THorizontalSpacing.m,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                race.participants
                                        .where((p) => p.swimmingSegment != null)
                                        .length
                                        .toString() ??
                                    '--',
                                style: TTextTheme.darkTextTheme.bodyMedium!
                                    .copyWith(
                                  fontSize: 22,
                                  color: RColor.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Swimming',
                                style: TTextTheme.darkTextTheme.bodySmall!
                                    .copyWith(
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          THorizontalSpacing.m,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                race.participants
                                        .where((p) => p.cyclingSegment != null)
                                        .length
                                        .toString() ??
                                    '--',
                                style: TTextTheme.darkTextTheme.bodyMedium!
                                    .copyWith(
                                  fontSize: 22,
                                  color: RColor.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Cycling',
                                style: TTextTheme.darkTextTheme.bodySmall!
                                    .copyWith(
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          THorizontalSpacing.m,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                race.participants
                                        .where((p) => p.runningSegment != null)
                                        .length
                                        .toString() ??
                                    '--',
                                style: TTextTheme.darkTextTheme.bodyMedium!
                                    .copyWith(
                                  fontSize: 22,
                                  color: RColor.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'running',
                                style: TTextTheme.darkTextTheme.bodySmall!
                                    .copyWith(
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          THorizontalSpacing.m,
                          SizedBox(
                            height: 60,
                            child: VerticalDivider(
                              color: RColor.black.withOpacity(0.5),
                              thickness: 0.5,
                            ),
                          ),
                          THorizontalSpacing.m,
                          DataRow(
                              title:
                                  race.countFinishedParticipants().toString() ??
                                      '--',
                              description: "finished")
                        ],
                      ),
                      TVerticalSpacing.xxl,
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              buildHeader(),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ParticipantRankData(
                    index: index + 1,
                    participant: race.participants[index],
                  );
                }, childCount: race.participants.length),
              )
            ],
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter buildHeader() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: RColor.primary.withOpacity(0.1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Rank',
                    style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: RColor.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Text(
                    'Participant',
                    style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: RColor.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        FontAwesomeIcons.personSwimming,
                        size: 17,
                        color: RColor.black.withOpacity(0.5),
                      ),
                      const SizedBox(width: 44),
                      Icon(
                        FontAwesomeIcons.personBiking,
                        size: 17,
                        color: RColor.black.withOpacity(0.5),
                      ),
                      const SizedBox(width: 46),
                      Icon(
                        FontAwesomeIcons.personRunning,
                        size: 17,
                        color: RColor.black.withOpacity(0.5),
                      ),
                      const SizedBox(width: 22),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRaceInfo(BuildContext context, Race? race) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DataRow(
                title: race?.sumAllDistances().toString() ?? '--' ,
                description: "Total Distance\n(km)",
              ),
              THorizontalSpacing.m,
              const SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: RColor.black,
                  thickness: 0.5,
                ),
              ),
              THorizontalSpacing.m,
              DataRow(
                title: race?.segments.length.toString()??'--' ,
                description: "Segments\n(count)",
              ),
              THorizontalSpacing.m,
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: RColor.black.withOpacity(0.5),
                  thickness: 0.5,
                ),
              ),
              THorizontalSpacing.m,
              const DataRow(
                title: "6:45",
                description: "Expect Time\n(km)",
              ),
            ],
          ),
          TVerticalSpacing.xxl,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DataRow(
                title: race?.startTime != null
                    ? DateFormat('hh:mm:ss')
                        .format(race?.startTime ?? DateTime.now())
                    : '--',
                description: "Start Time\n(hh:mm:ss)",
              ),
              THorizontalSpacing.m,
              const SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: RColor.black,
                  thickness: 0.5,
                ),
              ),
              THorizontalSpacing.m,
              DataRow(
                title: race?.endTime != null
                    ? DateFormat('hh:mm:ss').format(race!.endTime!)
                    : '--',
                description: "End Time\n(hh:mm:ss)",
              ),
            ],
          ),
          TVerticalSpacing.xxl,
          // Container(
          //   margin: const EdgeInsets.symmetric(horizontal: 10),
          //   width: MediaQuery.of(context).size.width,
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: RColor.primary,
          //     ),
          //     onPressed: () {
          //       Logger().d("mengthong");
          //     },
          //     child: const Text("View Details"),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildSwimmingPart(Race? race) {
    return race == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    // color: RColor.primary.withOpacity(0.8),
                    border: Border.all(
                      color: RColor.primary,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Swimming",
                    style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: RColor.black),
                  ),
                ),
                TVerticalSpacing.l,
                SplitsTable(
                  viewModel: viewModel,
                  segmentType: SegmentType.swimming,
                  race: race,
                ),
              ],
            ),
          );
  }

  Widget buildCyclingPart(Race? race) {
    return race == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    // color: RColor.primary.withOpacity(0.8),
                    border: Border.all(
                      color: RColor.primary,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Cycling",
                    style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: RColor.black),
                  ),
                ),
                TVerticalSpacing.l,
                race == null
                    ? const SizedBox.shrink()
                    : SplitsTable(
                        viewModel: viewModel,
                        race: race,
                        segmentType: SegmentType.cycling,
                      ),
              ],
            ),
          );
  }

  Widget buildRunningPart(Race? race) {
    return race == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    // color: RColor.primary.withOpacity(0.8),
                    border: Border.all(
                      color: RColor.primary,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    "Running",
                    style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: RColor.black),
                  ),
                ),
                TVerticalSpacing.l,
                race == null
                    ? const SizedBox.shrink()
                    : SplitsTable(
                        segmentType: SegmentType.running,
                        race: race,
                        viewModel: viewModel,
                      )
              ],
            ),
          );
  }
}

class DataRow extends StatelessWidget {
  final String title;
  final String description;

  const DataRow({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TTextTheme.darkTextTheme.bodyMedium!.copyWith(
              fontSize: 22, fontWeight: FontWeight.w600, color: RColor.primary),
        ),
        Text(
          description,
          style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
            fontSize: 10,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
