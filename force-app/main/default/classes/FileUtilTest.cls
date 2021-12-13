@IsTest
public class FileUtilTest {

	@IsTest
	static void testgetIcon() {
		System.assertEquals('doctype:audio', FileUtil.getIcon('test.mp3'));
		System.assertEquals('doctype:csv', FileUtil.getIcon('test.csv'));
		System.assertEquals('doctype:excel', FileUtil.getIcon('test.xlsx'));
		System.assertEquals('doctype:exe', FileUtil.getIcon('executable.exe'));
		System.assertEquals('doctype:html', FileUtil.getIcon('web.html'));
		System.assertEquals('doctype:image', FileUtil.getIcon('jpeg'));
		System.assertEquals('doctype:mp4', FileUtil.getIcon('test.mp4'));
		System.assertEquals('doctype:pdf', FileUtil.getIcon('PDF'));
		System.assertEquals('doctype:ppt', FileUtil.getIcon('test.PPSX'));
		System.assertEquals('doctype:rtf', FileUtil.getIcon('test.rtf'));
		System.assertEquals('doctype:txt', FileUtil.getIcon('TEST.text'));
		System.assertEquals('doctype:video', FileUtil.getIcon('somefile.mov'));
		System.assertEquals('doctype:word', FileUtil.getIcon('test.docx'));
		System.assertEquals('doctype:xml', FileUtil.getIcon('text.xml'));
		System.assertEquals('doctype:zip', FileUtil.getIcon('zip'));
		System.assertEquals('doctype:unknown', FileUtil.getIcon('test.test.unknown'));
		System.assertEquals('', FileUtil.getIcon(''));
		System.assertEquals(null, FileUtil.getIcon(null));
	}

	@IsTest
	static void testGetMimeType() {
		System.assertEquals('image/bmp', FileUtil.getMimeType('test.bmp'));
		System.assertEquals('text/csv', FileUtil.getMimeType('test.csv'));
		System.assertEquals('application/msword', FileUtil.getMimeType('doc'));
		System.assertEquals('application/vnd.openxmlformats-officedocument.wordprocessingml.document', FileUtil.getMimeType('test.docx'));
		System.assertEquals('image/jpeg', FileUtil.getMimeType('JPEG'));
		System.assertEquals('image/png', FileUtil.getMimeType('test.PNG'));
		System.assertEquals('application/pdf', FileUtil.getMimeType('TEST.pdf'));
		System.assertEquals('text/plain', FileUtil.getMimeType('test.txt'));
		System.assertEquals('application/vnd.ms-excel', FileUtil.getMimeType('xls'));
		System.assertEquals('application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', FileUtil.getMimeType('test.xlsx'));
		System.assertEquals('text/xml', FileUtil.getMimeType('XML'));
		System.assertEquals('application/octet-stream', FileUtil.getMimeType('test.test.unknown'));
		System.assertEquals('', FileUtil.getMimeType(''));
		System.assertEquals(null, FileUtil.getMimeType(null));
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
