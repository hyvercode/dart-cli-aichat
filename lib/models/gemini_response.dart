class GeminiResponse {
  final List<Candidate> candidates;
  final UsageMetadata usageMetadata;
  final String modelVersion;
  final String responseId;

  GeminiResponse({
    required this.candidates,
    required this.usageMetadata,
    required this.modelVersion,
    required this.responseId,
  });

  factory GeminiResponse.fromJson(Map<String, dynamic> json) {
    return GeminiResponse(
      candidates: (json['candidates'] as List)
          .map((e) => Candidate.fromJson(e))
          .toList(),
      usageMetadata: UsageMetadata.fromJson(json['usageMetadata']),
      modelVersion: json['modelVersion'],
      responseId: json['responseId'],
    );
  }
}

class Candidate {
  final Content content;
  final int index;

  Candidate({
    required this.content,
    required this.index,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      content: Content.fromJson(json['content']),
      index: json['index'],
    );
  }
}

class Content {
  final List<Part> parts;
  final String role;

  Content({
    required this.parts,
    required this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      parts: (json['parts'] as List).map((e) => Part.fromJson(e)).toList(),
      role: json['role'],
    );
  }
}

class Part {
  final String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    return Part(text: json['text']);
  }
}

class UsageMetadata {
  final int promptTokenCount;
  final int candidatesTokenCount;
  final int totalTokenCount;
  final List<PromptTokensDetail> promptTokensDetails;
  final int thoughtsTokenCount;

  UsageMetadata({
    required this.promptTokenCount,
    required this.candidatesTokenCount,
    required this.totalTokenCount,
    required this.promptTokensDetails,
    required this.thoughtsTokenCount,
  });

  factory UsageMetadata.fromJson(Map<String, dynamic> json) {
    return UsageMetadata(
      promptTokenCount: json['promptTokenCount'],
      candidatesTokenCount: json['candidatesTokenCount'],
      totalTokenCount: json['totalTokenCount'],
      promptTokensDetails: (json['promptTokensDetails'] as List)
          .map((e) => PromptTokensDetail.fromJson(e))
          .toList(),
      thoughtsTokenCount: json['thoughtsTokenCount'],
    );
  }
}

class PromptTokensDetail {
  final String modality;
  final int tokenCount;

  PromptTokensDetail({
    required this.modality,
    required this.tokenCount,
  });

  factory PromptTokensDetail.fromJson(Map<String, dynamic> json) {
    return PromptTokensDetail(
      modality: json['modality'],
      tokenCount: json['tokenCount'],
    );
  }
}
