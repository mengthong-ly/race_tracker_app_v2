part of 'participant_result_view.dart';

class _ParticipantResultAdaptive extends StatelessWidget {
  const _ParticipantResultAdaptive({
    required this.viewModel,
  });

  final ParticipantResultViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: viewModel.setRace(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: RColor.primary,
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TTextTheme.darkTextTheme.bodyLarge,
              ),
            ),
          );
        }
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  centerTitle: false,
                  leadingWidth: 30,
                  actions: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: RColor.primary,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(viewModel.participant.status),
                    ),
                    THorizontalSpacing.l
                  ],
                  backgroundColor: RColor.white,
                  title: Text('Participant Result',
                      style: TTextTheme.darkTextTheme.titleLarge),
                ),
              ];
            },
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TVerticalSpacing.l,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              buildTrophyCard(context),
                              SegmentCard(
                                icon: FontAwesomeIcons.personSwimming,
                                color: RColor.primary,
                                duration: viewModel.participant.swimmingSegment
                                        ?.durationForDisplay ??
                                    'Not Finished Yet',
                                label: 'Swimming Time',
                              ),
                              SegmentCard(
                                icon: FontAwesomeIcons.personBiking,
                                color: RColor.primary,
                                duration: viewModel.participant.cyclingSegment
                                        ?.durationForDisplay ??
                                    'Not Finished Yet',
                                label: 'Cycling Time',
                              ),
                              SegmentCard(
                                icon: FontAwesomeIcons.personRunning,
                                color: RColor.primary,
                                duration: viewModel.participant.runningSegment
                                        ?.durationForDisplay ??
                                    'Not Finished Yet',
                                label: 'Running Time',
                              ),
                            ],
                          ),
                        ),
                        TVerticalSpacing.l,
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Divider(
                                color: RColor.primary.withOpacity(0.5),
                                thickness: 0.4,
                              ),
                              TVerticalSpacing.l,
                              // swimming segment
                              const SectionLabel(text: 'Swimming Segment'),
                              TVerticalSpacing.l,
                              InfoRow(
                                leftTitle: viewModel.formatDurationHHMMSS(
                                  viewModel.participant.swimmingSegment
                                      ?.getDurationAsSecond(),
                                ),
                                leftSubtitle: 'Spend',
                                rightTitle:
                                    '${viewModel.race!.percentageOfSingleParticipantBeatOtherOnSwimming(viewModel.participant).toStringAsFixed(2)}%',
                                rightSubtitle: 'Top:',
                              ),
                              InfoRow(
                                leftTitle: viewModel.participant.swimmingSegment
                                            ?.startTime !=
                                        null
                                    ? DateFormat('hh:mm:ss').format(viewModel
                                        .participant
                                        .swimmingSegment!
                                        .startTime!)
                                    : 'Not Started yet',
                                leftSubtitle: 'Start At:',
                                rightTitle: viewModel.participant
                                            .swimmingSegment?.endTime !=
                                        null
                                    ? DateFormat('hh:mm:ss').format(viewModel
                                        .participant.swimmingSegment!.endTime!)
                                    : 'Not Started yet',
                                rightSubtitle: 'End At:',
                              ),
                              const SizedBox(height: 22),
                              Divider(
                                color: RColor.primary.withOpacity(0.5),
                                thickness: 0.4,
                              ),
                              // cycling segment
                              TVerticalSpacing.l,
                              const SectionLabel(text: 'Cycling Segment'),
                              TVerticalSpacing.l,
                              InfoRow(
                                leftTitle: viewModel.formatDurationHHMMSS(
                                  viewModel.participant.cyclingSegment
                                      ?.getDurationAsSecond(),
                                ),
                                leftSubtitle: 'Spend',
                                rightTitle:
                                    '${viewModel.race!.percentageOfSingleParticipantBeatOtherOnSwimming(viewModel.participant).toStringAsFixed(2)}%',
                                rightSubtitle: 'Top:',
                              ),
                              InfoRow(
                                leftTitle: viewModel.participant.cyclingSegment
                                            ?.startTime !=
                                        null
                                    ? DateFormat('hh:mm:ss').format(viewModel
                                        .participant.cyclingSegment!.startTime!)
                                    : 'Not Started yet',
                                leftSubtitle: 'Start At:',
                                rightTitle: viewModel.participant.cyclingSegment
                                            ?.endTime !=
                                        null
                                    ? DateFormat('hh:mm:ss').format(viewModel
                                        .participant.cyclingSegment!.endTime!)
                                    : 'Not Started yet',
                                rightSubtitle: 'End At:',
                              ),
                              const SizedBox(height: 22),
                              Divider(
                                color: RColor.primary.withOpacity(0.5),
                                thickness: 0.4,
                              ),
                              TVerticalSpacing.l,
                              const SectionLabel(text: 'Running Segment'),
                              TVerticalSpacing.l,
                              InfoRow(
                                leftTitle: viewModel.formatDurationHHMMSS(
                                  viewModel.participant.cyclingSegment
                                      ?.getDurationAsSecond(),
                                ),
                                leftSubtitle: 'Spend',
                                rightTitle:
                                    '${viewModel.race!.percentageOfSingleParticipantBeatOtherOnSwimming(viewModel.participant).toStringAsFixed(2)}%',
                                rightSubtitle: 'Top:',
                              ),
                              InfoRow(
                                leftTitle: viewModel.participant.cyclingSegment
                                            ?.startTime !=
                                        null
                                    ? DateFormat('hh:mm:ss').format(viewModel
                                        .participant.cyclingSegment!.startTime!)
                                    : 'Not Started yet',
                                leftSubtitle: 'Start At:',
                                rightTitle: viewModel.participant.cyclingSegment
                                            ?.endTime !=
                                        null
                                    ? DateFormat('hh:mm:ss').format(viewModel
                                        .participant.cyclingSegment!.endTime!)
                                    : 'Not Started yet',
                                rightSubtitle: 'End At:',
                              ),
                              const SizedBox(height: 22),
                              Divider(
                                color: RColor.primary.withOpacity(0.5),
                                thickness: 0.4,
                              ),
                              TVerticalSpacing.xxl,
                              const SectionLabel(text: 'Detial'),
                              TVerticalSpacing.xl,
                              buildProfileCard(),

                              const SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTrophyCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width * 0.66,
      height: MediaQuery.of(context).size.width * 0.36,
      decoration: const BoxDecoration(
        color: RColor.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              right: -200,
              child: Icon(
                FontAwesomeIcons.trophy,
                color: RColor.primary.withOpacity(0.1),
                size: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        color: RColor.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12)),
                    alignment: Alignment.center,
                    child: const Icon(
                      FontAwesomeIcons.trophy,
                      color: RColor.primary,
                      size: 20,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Top ${viewModel.getRank ?? '--'}",
                        style: TTextTheme.darkTextTheme.bodyLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: RColor.primary,
                        ),
                      ),
                      Text(
                        'Out of 100',
                        style: TTextTheme.darkTextTheme.bodyLarge!.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: RColor.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProfileCard() {
    return Container(
      decoration: const BoxDecoration(
        color: RColor.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: RColor.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: RColor.primary,
              size: 50,
            ),
          ),
          THorizontalSpacing.l,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoTextRow(label: 'Name:', value: viewModel.participant.name),
              InfoTextRow(label: 'Bib:', value: viewModel.participant.bib),
              InfoTextRow(label: 'Phone:', value: viewModel.participant.phone),
            ],
          ),
        ],
      ),
    );
  }
}
