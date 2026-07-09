class AiInsight {
  final String summary;
  final String priorityLabel;
  final String priorityRationale;
  final String suggestedAction;
  final List<String> actionSteps;
  final String ethicalNote;

  const AiInsight({
    required this.summary,
    required this.priorityLabel,
    required this.priorityRationale,
    required this.suggestedAction,
    required this.actionSteps,
    required this.ethicalNote,
  });
}
