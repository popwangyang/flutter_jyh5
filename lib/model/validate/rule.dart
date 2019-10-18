

enum ruleType{
  Text,
  Email,
  Phone,
  Array,
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