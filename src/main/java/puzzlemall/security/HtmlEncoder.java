/**
 * 
 */
package puzzlemall.security;

/**
 * @author Shay Chen
 * @since 1.0
 */
public final class HtmlEncoder {
	
	/**
     * This method encodes angle brackets (<,>) and quotes (',",`).
     * @param input Value to encode.
     * @return HTML encoded string (partial).
     * @since 1.0
     */
    public static String htmlEncode(final String input) {
        StringBuilder buffer = new StringBuilder(input.length());
        for (int i = 0; i < input.length(); i++) {
            char c = input.charAt(i);
            if (c == '<') {
                buffer.append("&lt;");
            } else if (c == '>') {
                buffer.append("&gt;");
            } else if (c == '"') {
                buffer.append("&quot;");
            } else if (c == '\'') {
                buffer.append("&#39;");
            } else if (c == '`') {
            	buffer.append("&#96;");
            } else {
                buffer.append(c);
            }
        }
        return buffer.toString();
    } //end of method

} //end of class
