

enum ruleType{
  Text,
  Email,
  Phone,
  Array,
  IDCard,
  Number,
  Password
}

class Rule {

  final bool require;
  final ruleType type;
  final String message;
  final String pattern;

  Rule({
    this.require = false,
    this.message,
    this.type = ruleType.Text,
    this.pattern
  }):assert(message != '');

  bool validate(dynamic data){
    bool result = true;
    if(this.require){
      if(this.type == ruleType.Array){
        result = data.length > 0 ? true:false;
      }else{
        result = (null != data && data != '');
      }
    }else{
      if(null != data && data != ''){  // 对与非必验证的如果为空或者null不与验证；
        if(this.pattern == null){
          switch(this.type){
            case ruleType.Email:
              RegExp regExp = new RegExp(r"^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$"); // 邮箱验证正则
              result = regExp.hasMatch(data);
              break;
            case ruleType.Phone:
              RegExp regExp = new RegExp(r"1[0-9]\d{9}$");
              result = regExp.hasMatch(data);
              break;
            case ruleType.IDCard:
              RegExp regExp = new RegExp(r"^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$");
              result = regExp.hasMatch(data);
              break;
            case ruleType.Number:
              RegExp regExp = new RegExp(r"^[0-9]*[1-9][0-9]*$");
              result = regExp.hasMatch(data);
              print(result);
              break;
            case ruleType.Password:
              RegExp regExp = new RegExp(r"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$");
              result = regExp.hasMatch(data);
              print(result);
              break;
            default:
              result = true;
          }
        }else{
          RegExp regExp = new RegExp(this.pattern);
          result = regExp.hasMatch(data);
        }
      }
    }
    return result;
  }
}