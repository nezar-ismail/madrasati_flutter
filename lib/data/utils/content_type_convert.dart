class ContentTypeConvert {
  static String getFileType(String filePath) {
    if (filePath.endsWith('.jpeg') || filePath.endsWith('.jpg')) {
      return 'image/jpeg';
    } else if (filePath.endsWith('.png')) {
      return 'image/png';
    } else if (filePath.endsWith('.webp')) {
      return 'image/webp';
    } else if (filePath.endsWith('.pdf')) {
      return 'application/pdf';
    } else if (filePath.endsWith('.doc') || filePath.endsWith('.docx')) {
      return 'application/msword';
    } else if (filePath.endsWith('.xls') || filePath.endsWith('.xlsx')) {
      return 'application/vnd.ms-excel';
    }
    return 'application/octet-stream'; // Default if no match
  }
}
