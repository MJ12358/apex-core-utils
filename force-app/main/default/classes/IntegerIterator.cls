/**
 * Created on Aug 24 2020
 *
 * Copyright (c) 2020 Matt Jants
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

public class IntegerIterator implements Iterator<Integer>, Iterable<Integer> {

	private Integer current;
	private Integer min;
	private Integer max;

	public IntegerIterator(Integer maxValue) {
		this(maxValue, 0);
	}

	public IntegerIterator(Integer maxValue, Integer minValue) {
		this.current = minValue;
		this.min = minValue;
		this.max = maxValue;
	}

	public Boolean hasNext() {
		return this.current < this.max;
	}

	public Integer next() {
		if (hasNext()) {
			return this.current++;
		}
		throw new System.NoSuchElementException();
	}

	public Boolean hasPrevious() {
		return this.current > this.min;
	}

	public Integer previous() {
		if (hasPrevious()) {
			return this.current--;
		}
		throw new System.NoSuchElementException();
	}

	public Integer first() {
		return this.min;
	}

	public Integer last() {
		return this.max;
	}

	public Iterator<Integer> iterator() {
		return this;
	}

}
