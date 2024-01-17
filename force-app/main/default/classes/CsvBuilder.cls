/**
 * Created on Mar 10 2020
 *
 * Copyright (c) 2020 MJ12358
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

public inherited sharing class CsvBuilder {

  public static final String WINDOWS_LINE_ENDING = '\r\n';
  public static final String UNIX_LINE_ENDING = '\n';

  @TestVisible
  private Map<String, Map<Integer, String>> headerToValues;
  private Integer currentRow;
  private String lineEnding;

  public CsvBuilder(String lineEnding) {
    this.currentRow = 0;
    this.headerToValues = new Map<String, Map<Integer, String>>();
    this.lineEnding = lineEnding;
  }

  public CsvBuilder() {
    this(WINDOWS_LINE_ENDING);
  }

  public CsvBuilder appendField(String headerName, Object fieldValue) {
    Map<Integer, String> column = headerToValues.containsKey(headerName) ? headerToValues.get(headerName) : new Map<Integer, String>();
    column.put(currentRow, String.valueOf(fieldValue));
    headerToValues.put(headerName, column);
    return this;
  }

  public CsvBuilder newRow() {
    currentRow++;
    return this;
  }

  public override String toString() {
    ColumnBuilder csvDocument = new ColumnBuilder(lineEnding);
    RowBuilder headerRow = new RowBuilder();
    RowBuilder[] rows = new RowBuilder[currentRow];
    for (String headerName : headerToValues.keySet()) {
      headerRow.add(headerName);
      Map<Integer, String> values = headerToValues.get(headerName);
      for (Integer rowIterator = 0; rowIterator < currentRow; rowIterator++) {
        String value = values.containsKey(rowIterator) ? values.get(rowIterator) : '';
        RowBuilder row = rows[rowIterator];
        if (row == null) {
          row = new RowBuilder();
        }
        value = value?.escapeCsv()
          .replaceAll('\r\n', ' ')
          .replaceAll('\n', ' ');
        row.add(value);
        rows[rowIterator] = row;
      }
    }
    csvDocument.add(headerRow);
    for (RowBuilder row : rows) {
      csvDocument.add(row);
    }
    return csvDocument.toString();
  }

  private class RowBuilder extends StringBuilder {

    public RowBuilder() {
      separator(',');
    }

  }

  private class ColumnBuilder extends StringBuilder {

    private Integer numberOfColumns;

    public ColumnBuilder(String lineEnding) {
      separator(lineEnding);
    }

    public ColumnBuilder add(RowBuilder rowToAdd) {
      Boolean isAddedRowValid = numberOfColumns == null || rowToAdd.length() == numberOfColumns;
      if (!isAddedRowValid) {
        throw new CsvBuilderException(System.Label.CsvColumnsInvalid);
      }
      numberOfColumns = rowToAdd.length();
      add(rowToAdd.toString());
      return this;
    }

  }

}
