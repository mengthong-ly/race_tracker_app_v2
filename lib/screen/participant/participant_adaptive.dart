part of 'participant_view.dart';

class _ParticipantAdaptive extends StatelessWidget {
  const _ParticipantAdaptive({
    required this.participantViewModel,
  });
  final ParticipantViewModel participantViewModel;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Participant',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            participantViewModel.isSelectedForRemove
                ? Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: RColor.primary.withOpacity(0.1),
                          foregroundColor: RColor.primary,
                          minimumSize: const Size(38, 28),
                        ),
                        onPressed: () async {
                          participantViewModel.onCancelRemove();
                        },
                        child: Text(
                          'Cancel',
                          style: TTextTheme.darkTextTheme.bodyMedium!
                              .copyWith(color: RColor.primary),
                        ),
                      ),
                      THorizontalSpacing.m,
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: RColor.error.withOpacity(0.2),
                          foregroundColor: RColor.error,
                          minimumSize: const Size(38, 28),
                        ),
                        onPressed: () async {
                          await participantViewModel.removeParticipants();
                        },
                        child: Text(
                          'Delete',
                          style: TTextTheme.darkTextTheme.bodyMedium!
                              .copyWith(color: RColor.error),
                        ),
                      ),
                    ],
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: RColor.primary.withOpacity(0.1),
                      foregroundColor: RColor.primary,
                      minimumSize: const Size(38, 28),
                    ),
                    onPressed: context
                            .read<RaceProvider>()
                            .raceService
                            .repository
                            .isRaceStarted
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: RColor.error,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 16),
                                duration: const Duration(seconds: 2),
                                content: const Text('Race Already Started'),
                              ),
                            );
                          }
                        : () async {
                            await context
                                .read<ParticipantProvider>()
                                .fetchParticipants();
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) {
                                  return const ParticipantDetailView();
                                },
                              ),
                            );
                          },
                    child: Text(
                      'Add',
                      style: TTextTheme.darkTextTheme.bodyMedium!
                          .copyWith(color: RColor.primary),
                    ),
                  ),
            THorizontalSpacing.m
          ],
          centerTitle: false,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              isScrollable: true,
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStatePropertyAll(Colors.transparent),
              splashBorderRadius: BorderRadius.all(Radius.circular(0)),
              indicatorColor: RColor.primary,
              labelColor: RColor.primary,
              tabAlignment: TabAlignment.start,
              tabs: [
                Tab(
                  child: Text('All'),
                ),
                Tab(
                  child: Text('Male'),
                ),
                Tab(
                  child: Text('Female'),
                ),
                Tab(
                  child: Text('Kids'),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            // All Participants
            StreamBuilder<List<Participant>>(
              stream: context.read<ParticipantProvider>().participantsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final participants = snapshot.data!;
                  return ListView.builder(
                    itemCount: participants.length,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      return ParticipantTile(
                        viewModel: participantViewModel,
                        participant: participants[index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: RColor.primary,
                    ),
                  );
                }
              },
            ),
            // Male Participants
            StreamBuilder<List<Participant>>(
              stream: context.read<ParticipantProvider>().participantsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final participants = snapshot.data!;
                  final maleParticipants = snapshot.data!
                      .where((element) => element.gender == Gender.male)
                      .toList();
                  return ListView.builder(
                    itemCount: maleParticipants.length,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      return ParticipantTile(
                        viewModel: participantViewModel,
                        participant: maleParticipants[index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: RColor.primary,
                    ),
                  );
                }
              },
            ),
            // Female Participants
            StreamBuilder<List<Participant>>(
              stream: context.read<ParticipantProvider>().participantsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final participants = snapshot.data!;
                  final femaleParticipants = snapshot.data!
                      .where((element) => element.gender == Gender.female)
                      .toList();
                  return ListView.builder(
                    itemCount: femaleParticipants.length,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      return ParticipantTile(
                        viewModel: participantViewModel,
                        participant: femaleParticipants[index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: RColor.primary,
                    ),
                  );
                }
              },
            ),
            // Kids Tab (example, you can filter as needed)
            StreamBuilder<List<Participant>>(
              stream: context.read<ParticipantProvider>().participantsStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // final participants = snapshot.data!;
                  final kids = snapshot.data!.where(
                    (element) {
                      return element.age < 14;
                    },
                  ).toList(); // Replace with your filter
                  return ListView.builder(
                    itemCount: kids.length,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      return ParticipantTile(
                        viewModel: participantViewModel,
                        participant: kids[index],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: RColor.primary,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
