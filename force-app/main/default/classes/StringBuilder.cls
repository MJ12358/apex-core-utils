/**
 * Copyright (c), FinancialForce.com, inc
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification, 
 *   are permitted provided that the following conditions are met:
 *
 * - Redistributions of source code must retain the above copyright notice, 
 *      this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright notice, 
 *      this list of conditions and the following disclaimer in the documentation 
 *      and/or other materials provided with the distribution.
 * - Neither the name of the FinancialForce.com, inc nor the names of its contributors 
 *      may be used to endorse or promote products derived from this software without 
 *      specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
 *  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES 
 *  OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL 
 *  THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
 *  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 *  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

/**
 * Created on Thur Nov 14 2019
 *
 * Copyright (c) 2019 MJ12358
 * All rights reserved.

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
 *  OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 *  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 **/

public virtual inherited sharing class StringBuilder {

  protected List<String> buffer = new List<String>();
  private String prefix = '';
  private String postfix = '';
  private String separator = '';
  
  public StringBuilder() {}
  
  public StringBuilder(List<String> values) {
    this.buffer = values;
  }

  //* Append

  public virtual StringBuilder add(String value) {
    this.buffer.add(value);
    return this;
  }
  
  public virtual StringBuilder add(List<String> values) {
    this.buffer.addAll(values);
    return this;
  }

  //* Prefix

  public virtual String prefix() {
    return this.prefix;
  }

  public virtual StringBuilder prefix(String value) {
    if (value != null) {
      this.prefix = value;
    }
    return this;
  }

  //* Separator

  public virtual String separator() {
    return this.separator;
  }

  public virtual StringBuilder separator(String value) {
    if (value != null) {
      this.separator = value;
    }
    return this;
  }

  //* Returns

  public Integer length() {
    return this.buffer.size();
  }

  public String toString(String prefix) {
    prefix(prefix);
    return toString();
  }

  public override String toString() {
    return prefix() + String.join(this.buffer, separator() + prefix());
  }

  //* Subclasses

  public virtual class CommaDelimitedListBuilder extends StringBuilder {

    public CommaDelimitedListBuilder() {
      separator(',');
    }

    public CommaDelimitedListBuilder(List<String> values) {
      super(values);
      separator(',');
    }

  }

  public virtual class FieldListBuilder extends CommaDelimitedListBuilder {

    private Boolean enforceFLS;

    public FieldListBuilder(Schema.SObjectType sObjectType) {
      this(sObjectType, true);
    }

    public FieldListBuilder(Schema.SObjectType sObjectType, Boolean enforceFLS) {
      this(sObjectType.getDescribe().fields.getMap().values(), enforceFLS);
    }

    public FieldListBuilder(Schema.FieldSet fieldSet) {
      this(fieldSet, true);
    }

    public FieldListBuilder(Schema.FieldSet fieldSet, Boolean enforceFLS) {
      this.enforceFLS = enforceFLS;
      for (Schema.FieldSetMember fieldMember : fieldSet.getFields()) {
        Schema.DescribeFieldResult dfr = fieldMember.getSObjectField().getDescribe();
        addField(dfr);
      }
    }

    public FieldListBuilder(List<Schema.SObjectField> fields) {
      this(fields, true);
    }

    public FieldListBuilder(List<Schema.SObjectField> fields, Boolean enforceFLS) {
      this.enforceFLS = enforceFLS;
      for (Schema.SObjectField field : fields) {
        Schema.DescribeFieldResult dfr = field.getDescribe();
        addField(dfr);
      }
    }

    private void addField(Schema.DescribeFieldResult dfr) {
      if (this.enforceFLS && dfr.isAccessible()) {
        this.buffer.add(dfr.getName());
      } else if (!this.enforceFLS) {
        this.buffer.add(dfr.getName());
      }
    }

  }
  
}