part of 'home_view.dart';

class _HomeAdaptive extends StatelessWidget {
  const _HomeAdaptive();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                ),
              ],
              title:
                  Text('Welcome', style: TTextTheme.darkTextTheme.titleLarge),
              centerTitle: false,
              pinned: true,
            ),
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: const Row(
                      children: [
                        ParticipantCard(),
                        RaceStatusCard(),
                      ],
                    ),
                  ),
                  TVerticalSpacing.l,
                  const ActionCard(),
                  TVerticalSpacing.l,
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: RColor.white,
                        foregroundColor: RColor.white,
                        surfaceTintColor: RColor.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: RColor.primary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return const ParticipantView();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'View Participant',
                        style: TTextTheme.darkTextTheme.bodyMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) {
              return const RaceView();
            },
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: RColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TVerticalSpacing.xxl,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: RColor.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.flag,
                size: 42,
                color: RColor.primary,
              ),
            ),
            const Spacer(),
            Text(
              'Start race',
              style: TTextTheme.darkTextTheme.titleLarge,
            ),
            Row(
              children: [
                Text(
                  'Click to start the race',
                  style: TTextTheme.darkTextTheme.bodyMedium,
                ),
                THorizontalSpacing.xxl,
                const Icon(
                  Icons.arrow_forward_rounded,
                  // size: 16,
                  color: RColor.primary,
                )
              ],
            ),
            TVerticalSpacing.xxl
          ],
        ),
      ),
    );
  }
}

class RaceStatusCard extends StatelessWidget {
  const RaceStatusCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: RColor.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 0),
            )
          ],
        ),
        margin: const EdgeInsets.only(right: 10, left: 6),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: RColor.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star_rounded,
                  color: RColor.primary,
                )),
            const Spacer(),
            Text(
              'Race',
              style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                color: RColor.black.withOpacity(0.7),
              ),
            ),
            Text(
              'UnStarted',
              style: TTextTheme.darkTextTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ParticipantCard extends StatelessWidget {
  const ParticipantCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: RColor.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 0),
              )
            ]),
        margin: const EdgeInsets.only(left: 10, right: 6),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: StreamBuilder<List<Participant>>(
            stream: context.watch<ParticipantProvider>().participantsStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: RColor.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.group,
                          color: RColor.primary,
                        )),
                    const Spacer(),
                    Text(
                      'Participants',
                      style: TTextTheme.darkTextTheme.bodySmall!.copyWith(
                        color: RColor.black.withOpacity(0.7),
                      ),
                    ),
                    Text(
                      snapshot.data!.length.toString(),
                      style: TTextTheme.darkTextTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
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
        ),
      ),
    );
  }
}
