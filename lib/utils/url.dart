import 'package:flutter_dotenv/flutter_dotenv.dart';

String getS3ImageUrl(
  BucketCategory category,
  String fileName,
) {
  String cate = '';
  if (category == BucketCategory.candidates) {
    cate = 'candidates';
  }
  return '${dotenv.env['S3_BUCKET_URL']}/$cate/$fileName';
}

enum BucketCategory { candidates }

String getNormalizedUrl(String link) {
  Uri url = Uri.parse(link);
  if (!url.isAbsolute) return 'https://$url';

  return link;
}
