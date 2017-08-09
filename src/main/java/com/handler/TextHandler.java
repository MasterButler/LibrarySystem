package com.handler;

import org.owasp.html.PolicyFactory;
import org.owasp.html.Sanitizers;

public class TextHandler {
	
	public static String sanitize(String untrustedHTML){
		PolicyFactory policy = Sanitizers.FORMATTING.and(Sanitizers.LINKS);
		String safeHTML = policy.sanitize(untrustedHTML);
		System.out.println("FROM " + untrustedHTML + " TO " + safeHTML);
		return safeHTML;
	}
}
