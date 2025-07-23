enum Gender {
  male(label: "male"),
  female(label: "female");

  final String label;
  const Gender({required this.label});
}

enum Status {
  active(label: "Active"),
  inactive(label: "Not Started"),
  finished(label: "Finished");

  final String label;
  const Status({required this.label});
}

enum Nation {
  vn(label: "Vietnam"),
  us(label: "United States"),
  jp(label: "Japan"),
  kr(label: "Korea"),
  cn(label: "China"),
  kh(label: "Cambodia");

  final String label;
  const Nation({required this.label});
}
