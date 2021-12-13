/**
 * Created on Aug 26 2019
 *
 * Copyright (c) 2019 Matt Jants
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *    are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *    this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *    this list of conditions and the following disclaimer in the documentation 
 *    and/or other materials provided with the distribution.
 * - Neither the name of the company, software or the names of its contributors 
 *    may be used to endorse or promote products derived from this software without 
 *    specific prior written permission.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 *  TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, TORT (INCLUDING NEGLIGENCE) OR OTHERWISE, 
 *  ARISING FROM, OUT OF OR IN CONNECTION WITH THE USE OF THIS SOFTWARE OR OTHER DEALINGS IN THE SOFTWARE, 
 *  EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

public class FileUtil {

	public static String getExtension(String fileName) {
		if (String.isBlank(fileName)) {
			return fileName;
		}
		List<String> s = fileName.split('\\.');
		if (s.size() > 0) {
			return s[s.size() - 1];
		}
		return fileName;
	}

	public static String getName(String fileName) {
		if (String.isBlank(fileName)) {
			return fileName;
		}
		return fileName.substringBeforeLast('.');
	}

	public static String getIcon(String fileName) {
		if (String.isBlank(fileName)) {
			return fileName;
		}
		String extension = getExtension(fileName).toLowerCase();
		switch on extension {
			when 'aac', 'aiff', 'oga', 'ogg', 'f4a', 'f4b', 'mp3', 'wav', 'weba', 'wma' {
				return 'doctype:audio';
			}
			when 'csv' {
				return 'doctype:csv';
			}
			when 'ods', 'xls', 'xlam', 'xlsb', 'xlsm', 'xlsx' {
				return 'doctype:excel';
			}
			when 'exe' {
				return 'doctype:exe';
			}
			when 'bmp', 'jpg', 'jpeg', 'jpe', 'png', 'gif', 'tif', 'tiff', 'webp' {
				return 'doctype:image';
			}
			when 'html', 'xhtml' {
				return 'doctype:html';
			}
			when 'f4v', 'f4p', 'm4v', 'mp4' {
				return 'doctype:mp4';
			}
			when 'pdf', 'xfa', 'xfdf' {
				return 'doctype:pdf';
			}
			when 'odp', 'pps', 'ppsx', 'ppsxm', 'ppt', 'pptm', 'pptx' {
				return 'doctype:ppt';
			}
			when 'rtf' {
				return 'doctype:rtf';
			}
			when 'crtext', 'css', 'text', 'txt' {
				return 'doctype:txt';
			}
			when 'avi', 'mpeg', 'mpe', 'mov', 'ogv', 'qt', 'ts', 'webm' {
				return 'doctype:video';
			}
			when 'vsd', 'vsdx' {
				return 'doctype:visio';
			}
			when 'doc', 'docx', 'dot', 'dotm', 'dotx', 'odt' {
				return 'doctype:word';
			}
			when 'svg', 'svgz', 'xml' {
				return 'doctype:xml';
			}
			when '7z', 'bz', 'bz2', 'gzip', 'zip' {
				return 'doctype:zip';
			}
			when else {
				return 'doctype:unknown';
			}
		}
	}

	public static String getMimeType(String fileName) {
		if (String.isBlank(fileName)) {
			return fileName;
		}
		String extension = getExtension(fileName).toLowerCase();
		switch on extension {
			when 'aac' {
				return 'audio/aac';
			}
			when 'avi' {
				return 'video/x-msvideo';
			}
			when 'bmp' {
				return 'image/bmp';
			}
			when 'css' {
				return 'text/css';
			}
			when 'csv' {
				return 'text/csv';
			}
			when 'doc' {
				return 'application/msword';
			}
			when 'docx' {
				return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
			}
			when 'f4a', 'f4b', 'm4a' {
				return 'audio/mp4';
			}
			when 'f4v', 'f4p', 'm4v', 'mp4' {
				return 'video/mp4';
			}
			when 'flv' {
				return 'video/x-flv';
			}
			when 'gif' {
				return 'image/gif';
			}
			when 'htm', 'html' {
				return 'text/html';
			}
			when 'jpg', 'jpeg', 'jpe' {
				return 'image/jpeg';
			}
			when 'js', 'ts' {
				return 'text/javascript';
			}
			when 'json' {
				return 'application/json';
			}
			when 'mov', 'qt' {
				return 'video/quicktime';
			}
			when 'mp3' {
				return 'audio/mpeg';
			}
			when 'mpeg', 'mpe' {
				return 'video/mpeg';
			}
			when 'oga' {
				return 'audio/ogg';
			}
			when 'ogv' {
				return 'video/ogg';
			}
			when 'pgm' {
				return 'image/x-portable-graymap';
			}
			when 'pdf' {
				return 'application/pdf';
			}
			when 'png' {
				return 'image/png';
			}
			when 'ppm' {
				return 'image/x-portable-pixmap';
			}
			when 'ppt' {
				return 'application/vnd.ms-powerpoint';
			}
			when 'pptx' {
				return 'application/vnd.openxmlformats-officedocument.presentationml.presentation';
			}
			when 'svg', 'svgz' {
				return 'image/svg+xml';
			}
			when 'tif', 'tiff' {
				return 'image/tiff';
			}
			when 'txt' {
				return 'text/plain';
			}
			when 'vsd' {
				return 'application/vnd.visio';
			}
			when 'wav' {
				return 'audio/wav';
			}
			when 'weba' {
				return 'audio/webm';
			}
			when 'webm' {
				return 'video/webm';
			}
			when 'xls' {
				return 'application/vnd.ms-excel';
			}
			when 'xlsx' {
				return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
			}
			when 'atom', 'rdf', 'rss', 'xml' {
				return 'text/xml';
			}
			when else {
				return 'application/octet-stream';
			}
		}
	}

	public static String sizeToString(Integer value) {
		if (value == null) {
			return '0 Bytes';
		}

		if (value < 1024) {
			return String.valueOf(value) + ' Bytes';
		}

		if (value >= 1024 && value < (1024 * 1024)) {
			Decimal kb = Decimal.valueOf(value).divide(1024, 2).stripTrailingZeros();
			return String.valueOf(kb) + ' KB';
		}

		if (value >= (1024 * 1024) && value < (1024 * 1024 * 1024)) {
			Decimal mb = Decimal.valueOf(value).divide((1024 * 1024), 2).stripTrailingZeros();
			return String.valueOf(mb) + ' MB';
		}

		Decimal gb = Decimal.valueOf(value).divide((1024 * 1024 * 1024), 2).stripTrailingZeros();
		return String.valueOf(gb) + ' GB';
	}

	public static Boolean isImage(String value) {
		if (String.isBlank(value)) {
			return false;
		}
		String extension = getExtension(value).toLowerCase();
		switch on extension {
			when 'bmp', 'jpg', 'jpeg', 'jpe', 'pgm', 'png', 'ppm', 'gif', 'tif', 'tiff', 'webp' {
				return true;
			}
			when else {
				return false;
			}
		}
	}

	public static Boolean isAudio(String value) {
		if (String.isBLank(value)) {
			return false;
		}
		String extension = getExtension(value).toLowerCase();
		switch on extension {
			when 'aac', 'aiff', 'oga', 'ogg', 'f4a', 'f4b', 'mp3', 'wav', 'weba', 'wma' {
				return true;
			}
			when else {
				return false;
			}
		}
	}

	public static Boolean isVideo(String value) {
		if (String.isBLank(value)) {
			return false;
		}
		String extension = getExtension(value).toLowerCase();
		switch on extension {
			when 'avi', 'f4v', 'f4p', 'm4v', 'mp4', 'mpeg', 'mpe', 'mov', 'ogv', 'qt', 'ts', 'webm' {
				return true;
			}
			when else {
				return false;
			}
		}
	}

}
