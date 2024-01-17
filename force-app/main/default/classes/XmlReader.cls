/**
 * Created on Nov 7 2019
 *
 * Copyright (c) 2019 MJ12358
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

// TODO: need more input on this
  // as i dont normally work with xml

public class XmlReader {

  private System.XmlStreamReader reader;
  private String xmlns;
  private String result;

  public XmlReader(String xml) {
    this.reader = new System.XmlStreamReader(xml); 
    this.result = '';
  }

  public XmlReader(Dom.Document document) {
    this(document.toXmlString());
  }

  public XmlReader setNamespace(String value) {
    this.xmlns = value;
    return this;
  }

  public XmlReader getAttribute(String element, String attribute) {
    while (this.reader.hasNext()) {
      if (this.reader.getEventType() == System.XmlTag.START_ELEMENT 
          && this.reader.getLocalName().equalsIgnoreCase(element)) {
        this.result = this.reader.getAttributeValue(xmlns, attribute);
        break;
      }
      this.reader.next();
    }
    return this;
  }

  public XmlReader getElement(String element) {
    while (this.reader.hasNext()) {
      if (this.reader.getEventType() == System.XmlTag.START_ELEMENT 
          && this.reader.getLocalName().equalsIgnoreCase(element)) {
        while (this.reader.hasNext()) {
          this.reader.next();
          if (this.reader.getEventType() == System.XmlTag.CHARACTERS) {
            this.result = this.reader.getText();
            break;
          }
        }
      }
      this.reader.next();
    }
    return this;
  }

  public System.XmlStreamReader getReader() {
    return this.reader;
  }

  public String getResult() {
    return this.result.normalizeSpace();
  }

}
