import 'package:jobxprss_company/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
export 'package:jobxprss_company/main_app/views/widgets/custom_zefyr_rich_text_from_field.dart';
import 'package:notustohtml/notustohtml.dart';
export 'package:notustohtml/notustohtml.dart';
import 'package:quill_delta/quill_delta.dart';
export 'package:quill_delta/quill_delta.dart';
import 'package:jobxprss_company/method_extension.dart';

class ZeyfrHelper {
  static NotusDocument htmlToNotusDocument(String htmlString) {
    if (htmlString.isEmptyOrNull) {
      return NotusDocument();
    }
    final converter = NotusHtmlCodec();
    Delta delta = converter.decode("$htmlString\n"); // Zefyr compatible Delta
    NotusDocument document = NotusDocument.fromDelta(delta); //
    return document;
  }

  static String notusDocumentToHTML(NotusDocument notusDocument) {

    final converter = NotusHtmlCodec();

    String html = converter.encode(notusDocument.toDelta());
    return html;
  }
}
