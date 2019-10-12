

enum ruleType{
  Email,
  Password,
  Text,
}

class Rule {

  final bool require;
  final ruleType type;
  final String message;

  Rule({this.require = false, this.message, this.type = ruleType.Text})
      :assert(message != '');



}