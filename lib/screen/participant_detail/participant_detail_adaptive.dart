part of 'participant_detail_view.dart';

class _ParticipantDetailAdaptive extends StatelessWidget {
  const _ParticipantDetailAdaptive({required this.viewModel});

  final ParticipantDetailViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return  ParticipantFormView(
      isEdit: viewModel.isEdit,
      participant: viewModel.participant,
    );
  }
}
