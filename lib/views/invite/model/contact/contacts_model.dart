class ContactsModel {
  List<String> contacts;
  ContactsModel({required this.contacts});

  /// Encode and manipute list of contacts here before returning
  /// manipulated values
  List _encondeList(List<String> list) {
    List _list = [];
    list.map((item) => _list.add('''"$item"''')).toList();
    return _list;
  }

  String comparePhoneContactWithDiceContact(List<String> contacts) {
    return """
      mutation{
          comparePhoneContactWithDiceContact(input: ${_encondeList(contacts)} ){
            contacts{
              isExist
              user{
                id
                name
                username 
                phone
                photo
              }
            }
          }
      }
    """;
  }
}
