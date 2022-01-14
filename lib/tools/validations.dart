
import 'package:deva_portal/models/addresses/district_model.dart';
import 'package:deva_portal/models/addresses/neighborhood_model.dart';
import 'package:deva_portal/models/addresses/provincial_model.dart';
import 'package:deva_portal/models/component_models/dropdown_search_model.dart';

class FormValidations{

  static String? UserNameValidation(String val){
    if(val.length<=0){
      return"Kullanıcı Adı Boş Olamaz!";
    }
    if(val.length<3){
      return"Kullanıcı Adı 3 Karakterden Küçük Olamaz";
    }
    return null;
  }

  static String? PasswordValidation(String val){
    if(val.length<=0){
      return"Şifre Boş Olamaz!";
    }
    if(val.length<7){
      return"Şifre 8 Karakterden Küçük Olamaz";
    }
    return null;
  }
  static String? NumberConfirmeCodeValidation(String val){
    if(val.length<=0){
      return"Kod Boş Olamaz!";
    }
    if(val.length!=6){
      return"Hatalı Kod";
    }
    return null;
  }
  static String? EmailValidation(String val){
    if(val.length<=0){
      return"Email Boş Olamaz";
    }
    if(!val.contains("@")&val.contains(".com")){
      return"Lütfen Geçerli Bir Emil Yazınız";
    }
    return null;
  }
  static NonEmty(String val){

    if(val.length<=0){
      return"Boş Olamaz";
    }
  }
  static PhoneValidation(String val){
    if(val.length<10){
      return"Lütfen Geçerli Bir Telefon Girin";
    }
    if(val[0]=="0"){
      return"Telefon Numaranızı Başında '0' Olmadan Girin";
    }
  }
  static identityNumberValidation(String val){
    if(val.length!=11){
      return"Lütfen Geçerli Kimlik Numarası Giriniz";
    }
    if(val[0]=="0"){
      return"Lütfen Geçerli Kimlik Numarası Giriniz";
    }
  }
  static ProvincialValidation(Provincial? val){
    if(val==null){
      return "Lütfen İl Seçiniz";
    }
  }
  static requaredDropdown(DropdownSearchModel? val){
    if(val==null){
      return "Lütfen Seçiniz";
    }
  }
  static DistrictValidation(dynamic val){
    if(val==null){
      return "Lütfen İlçe Seçiniz";
    }
  }
  static NeighborhoodValidation(Neighborhood? val){
    if(val==null){
      return "Lütfen İlçe Seçiniz";
    }
  }
}