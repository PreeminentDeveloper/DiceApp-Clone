class CodeNameModel {
  final String? codeName;


  CodeNameModel(this.codeName);

  String codeNameExists = '''
  query (\$codeName: String!){
    codeNameExists(codeName: \$codeName)
  }
  ''';
}
