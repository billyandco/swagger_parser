import '../../utils/case_utils.dart';
import '../../utils/type_utils.dart';
import '../../utils/utils.dart';
import '../models/programming_lang.dart';
import '../models/universal_component_class.dart';
import '../models/universal_type.dart';

/// Provides template for generating kotlin DTO using Moshi
String kotlinMoshiDtoTemplate(UniversalComponentClass dataClass) {
  return '''
import com.squareup.moshi.Json
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class ${dataClass.name.toPascal}(${_parameters(dataClass.parameters)}${dataClass.parameters.isNotEmpty ? '\n)' : ')'}
''';
}

String _parameters(List<UniversalType> parameters) => parameters
    .map(
      (e) =>
          '${e.jsonKey != null && e.name != e.jsonKey ? '\n    @Json("${e.jsonKey}")' : ''}\n    '
          'var ${e.name}: ${toSuitableType(e, ProgrammingLanguage.kotlin, isRequired: e.isRequired)}'
          '${e.defaultValue != null ? ' = ${e.type.quoterForStringType(isDart: false)}'
              '${e.defaultValue}${e.type.quoterForStringType(isDart: false)}' : ''},',
    )
    .join();
