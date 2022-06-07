@IsTest
public class FileUtilTest {

  private static Map<String, String> iconMap = new Map<String, String>{
    'test.mp3' => 'doctype:audio',
    'test.csv' => 'doctype:csv',
    'test.xlsx' => 'doctype:excel',
    'test.exe' => 'doctype:exe',
    'test.html' => 'doctype:html',
    'test.jpeg' => 'doctype:image',
    'jpeg' => 'doctype:image',
    'test.mp4' => 'doctype:mp4',
    'test.pdf' => 'doctype:pdf',
    'test.PPSX' => 'doctype:ppt',
    'test.rtf' => 'doctype:rtf',
    'TEST.text' => 'doctype:txt',
    'test.mov' => 'doctype:video',
    'test.vsd' => 'doctype:visio',
    'test.docx' => 'doctype:word',
    'test.xml' => 'doctype:xml',
    'test.zip' => 'doctype:zip',
    'unknown' => 'doctype:unknown',
    'test.test.unknown' => 'doctype:unknown'
  };

  private static Map<String, String> mimeTypeMap = new Map<String, String>{
    'unknown' => 'application/octet-stream',
    'test.test.unknown' => 'application/octet-stream',
    'doc' => 'application/msword',
    'TEST.pdf' => 'application/pdf',
    'docx' => 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    'xlsx' => 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    'test.xls' => 'application/vnd.ms-excel',
    'test.aiff' => 'audio/aiff',
    'test.m4a' => 'audio/mp4',
    'test.bmp' => 'image/bmp',
    'JPEG' => 'image/jpeg',
    'test.PNG' => 'image/png',
    'test.css' => 'text/css',
    'test.csv' => 'text/csv',
    'test.txt' => 'text/plain',
    'XML' => 'text/xml',
    'test.flv' => 'video/x-flv',
    'test.mpe' => 'video/mpeg'
  };

  @IsTest
  static void testGetIcon() {
    for (String key : iconMap.keySet()) {
      System.assertEquals(iconMap.get(key), FileUtil.getIcon(key));
    }
  }

  @IsTest
  static void testGetMimeType() {
    for (String key : mimeTypeMap.keySet()) {
      System.assertEquals(mimeTypeMap.get(key), FileUtil.getMimeType(key));
    }
  }

  @IsTest
  static void testsizeToString() {
    System.assertEquals('0 Bytes', FileUtil.sizeToString(0));
    System.assertEquals('1023 Bytes', FileUtil.sizeToString(1023));
    System.assertEquals('2 KB', FileUtil.sizeToString(2048));
    System.assertEquals('4 MB', FileUtil.sizeToString(4194304));
    System.assertEquals('1 GB', FileUtil.sizeToString(1073741824));
    System.assertEquals('0 Bytes', FileUtil.sizeToString(null));
  }

  @IsTest
  static void testIsAudio() {
    System.assertEquals(true, FileUtil.isAudio('Music_609802916.02583.mp3'));
    System.assertEquals(true, FileUtil.isAudio('test.mp3'));
    System.assertEquals(true, FileUtil.isAudio('test.aac'));
    System.assertEquals(true, FileUtil.isAudio('test.wav'));
    System.assertEquals(true, FileUtil.isAudio('mp3'));
    System.assertEquals(true, FileUtil.isAudio('AAC'));
    System.assertEquals(false, FileUtil.isAudio('test.pdf'));
    System.assertEquals(false, FileUtil.isAudio('test'));
    System.assertEquals(false, FileUtil.isAudio(null));
  }

  @IsTest
  static void testIsImage() {
    System.assertEquals(true, FileUtil.isImage('Photo_609802916.02583.jpg'));
    System.assertEquals(true, FileUtil.isImage('test.jpg'));
    System.assertEquals(true, FileUtil.isImage('test.JPEG'));
    System.assertEquals(true, FileUtil.isImage('test.png'));
    System.assertEquals(true, FileUtil.isImage('jpg'));
    System.assertEquals(true, FileUtil.isImage('PNG'));
    System.assertEquals(false, FileUtil.isImage('test.pdf'));
    System.assertEquals(false, FileUtil.isImage('test'));
    System.assertEquals(false, FileUtil.isImage(null));
  }

  @IsTest
  static void testIsVideo() {
    System.assertEquals(true, FileUtil.isVideo('Video_609802916.02583.mp4'));
    System.assertEquals(true, FileUtil.isVideo('test.mp4'));
    System.assertEquals(true, FileUtil.isVideo('test.mov'));
    System.assertEquals(true, FileUtil.isVideo('test.avi'));
    System.assertEquals(true, FileUtil.isVideo('mp4'));
    System.assertEquals(true, FileUtil.isVideo('MOV'));
    System.assertEquals(false, FileUtil.isVideo('test.pdf'));
    System.assertEquals(false, FileUtil.isVideo('test'));
    System.assertEquals(false, FileUtil.isVideo(null));
  }

}
