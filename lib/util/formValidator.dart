class Validator {
  static String validateEmail(String value) {
    Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email address.';
    else
      return null;
  }

  static String validatePassword(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Password must be at least 6 characters.';
    else
      return null;
  }

  static String validateName(String value) {
    Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a name.';
    else
      return null;
  }

  static String validateNumber(String value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a number.';
    else
      return null;
  }
static String validatePhoneNumber(String value) {
    Pattern pattern = r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid phone number.';
    else
      return null;
  }
static String validateOTP(String value) {
    Pattern pattern = r'^(\s*\d{6}\s*)(,\s*\d{6}\s*)*,?\s*$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter valid OTP';
    else
      return null;
  }
static String validatePanNo(String value) {
    Pattern pattern = r'^[a-zA-Z]{3}[abcfghljptfABCFGHLJPTF]{1}[a-zA-Z]{1}[0-9]{4}[a-zA-Z]{1}';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter Valid Pancard';
    else
      return null;
  }  
  


  static String validatePayAmount(String value) {
    Pattern pattern = r'^[0-9]+';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter valid amount.';
    else
      return null;
  }

  static String validateReferralCode(String value) {
    Pattern pattern = r'^.{6,}$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Referral Code must be at least 6 characters.';
    else
      return null;
  }
}

