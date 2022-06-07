/**
 * Created on Dec 10 2019
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

public inherited sharing class EmailUtil {

/**
 *  Simply send an email
 *  @param String subject
 *  @param String message
 *  @param List<String> toAddresses
 */
  public static void send(String subject, String message, List<String> toAddresses) {
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(toAddresses);
		mail.setSubject(subject);
		mail.setPlainTextBody(message);
		mail.setSaveAsActivity(false);
		Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
  }

/**
 *  Simply send an email
 *  @param String subject
 *  @param String message
 *  @param String toAddress
 */
  public static void send(String subject, String message, String toAddress) {
    List<String> toAddresses = new List<String>{ toAddress };
    send(subject, message, toAddresses);
  }

	//* Send debug

/**
 *	Send a debug message
 *    to all who subscribe to apex notifications
 *	@param String subject
 *	@param String message
 *	@param Exception
 */
	public static void sendDebug(String subject, String message, Exception e) {
    List<String> toAddresses = getApexNotification();
    if (toAddresses.isEmpty()) {
      return; // TODO: what to do in this case
    }
		String errorMessage = String.format('Cause :: {0}\nType :: {1}\nLine Number :: {2}\nMessage :: {3}\nStackTrace :: {4}',
			new List<Object>{
				e.getCause(),
				e.getTypeName(),
				e.getLineNumber(),
				e.getMessage(),
				e.getStackTraceString()
			}
		);
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(toAddresses);
		mail.setSubject(subject);
		mail.setPlainTextBody(errorMessage + '\n' + message);
		mail.setSaveAsActivity(false);
		Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
	}

	public static void sendDebug(String message, Exception e) {
		sendDebug('An apex error occurred', message, e);
	}

	public static void sendDebug(String message) {
		sendDebug(message, new DmlException());
	}

	//* Send info

/**
 *	Send an informational message
 *    to all who subscribe to apex notifications
 *	@param String subject
 *	@param String message
 */
	public static void sendInfo(String subject, String message) {
    List<String> toAddresses = getApexNotification();
    if (toAddresses.isEmpty()) {
      return; // TODO: what to do in this case
    }
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		mail.setToAddresses(toAddresses);
		mail.setSubject(subject);
		mail.setPlainTextBody(message);
		mail.setSaveAsActivity(false);
		Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
	}

/**
 *  Send an informational message
 *    to all who subscribe to apex notifications
 *  @param String message
 */
	public static void sendInfo(String message) {
		sendInfo('Apex informational statement', message);
	}

/**
 *  Get email addresses of users subscribed to apex notifications
 *  @return List<String>
 */
	public static List<String> getApexNotification() {
		List<String> emailAddresses = new List<String>();
		Set<Id> userIds = new Set<Id>();
		for (ApexEmailNotification aen : [SELECT Email, UserId FROM ApexEmailNotification]) {
			if (aen.Email == null && aen.UserId != null) {
				userIds.add(aen.UserId);
			} else if (aen.Email != null) {
				emailAddresses.add(aen.Email);
			}
		}
		if (!userIds.isEmpty()) {
			for (User u : [SELECT Email FROM User WHERE Id IN :userIds]) {
				if (u.Email != null) {
					emailAddresses.add(u.Email);
				}
			}
		}
		return emailAddresses;
	}

/**
 *	Attempt to strip replies from an email body
 *	@param String The from address
 *	@param String The email body
 *	@return String
 */
	public static String stripReplies(String address, String body) {
		List<System.Pattern> patterns = new List<System.Pattern>{
			System.Pattern.compile('(?i)From:\\s*'), // common
			System.Pattern.compile('(?i)<' + address + '>'), // common
			System.Pattern.compile('(?i)' + address + '\\s+wrote:'),
			System.Pattern.compile('(?i)On.*(\\r\\n)?wrote:'), // osx mail
			System.Pattern.compile('(?i)-+original\\s+message-+'), // ms outlook default
			System.Pattern.compile('________________________________') // outlook
		};
		Integer index = body.length();
		for (System.Pattern p : patterns) {
			System.Matcher m = p.matcher(body);
			if (m.find() && m.start() < index) {
				index = m.start();
			}
		}
		return body.substring(0, index).trim();
	}

}