<cfscript>

	// Setup request parameter defaults (the union of URL and FORM scopes).
	param name="request.spaRoute" type="string" default="";
	param name="request.redirectTo" type="string" default="";
	param name="request.submitted" type="boolean" default="false";

	// NOTE: For the sake of simplicity, submitting the login form in this demo is good-
	// enough for authentication - we're here to focus on the URL handling, not on how to
	// authenticate users.
	if ( request.submitted ) {

		session.isLoggedIn = true;

		// Once the user is logged-in, we are either going to redirect them to the
		// default SPA experience; or, we're going to redirect them to the provided URL.
		// In both cases, we need to append the "spaRoute" to the destination URL.
		// --
		// Redirect to a specific page after authentication.
		if ( request.redirectTo.len() ) {

			// CAUTION: In a production setting, you MAY have to take more precaution
			// around how you redirect the user after (or as part of) authentication. In
			// some cases, not sanitizing the redirection-URL can lead to a PERSISTED XSS
			// (Cross-Site Scripting) attack (especially if you need to forward the user
			// to a Single Sign-On identity provider that, in some way, echoes its "relay
			// state" on the login page). For the sake of this demo, I am more-or-less
			// trusting the redirectTo value.
			nextUrl = new DynamicUrl()
				.parseUrl( request.redirectTo )
				.addUrlParamIfPopulated( "spaRoute", request.spaRoute )
				.toUrl()
			;

		// Redirect to the default SPA experience after authentication.
		} else {

			nextUrl = new DynamicUrl( "./spa.cfm" )
				.addUrlParamIfPopulated( "spaRoute", request.spaRoute )
				.toUrl()
			;

		}

		location( url = nextUrl, addToken = false );		

	}

</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<title>
			Log Into the Single-Page Application (SPA)
		</title>
	</head>
	<body>

		<h1>
			Log Into the Single-Page Application (SPA)
		</h1>

		<form method="post" action="#encodeForHtmlAttribute( cgi.script_name )#">

			<input type="hidden" name="submitted" value="true" />
			<input type="hidden" name="redirectTo" value="#encodeForHtmlAttribute( request.redirectTo )#" />
			<!--- Hook to convert URL fragment into URL search parameter. --->
			<input type="hidden" name="spaRoute" value="#encodeForHtmlAttribute( request.spaRoute )#" />

			<button type="submit">
				Login
			</button>

		</form>

		<hr />

		<p>
			<a href="./ingress.cfm">Back to demo URLs</a> &rarr;
		</p>

		<script type="text/javascript">

			// If the main SPA experience redirected the user to the login form, the URL
			// fragment was likely kept in tact (since a browser redirect doesn't remove
			// it implicitly). However, when the user submits the login form, we'll lose
			// any fragment by default. As such, if a fragment exists, let's convert it
			// to a "spaHash" parameter and store it in the FORM so that it will get
			// submitted along with the login.
			document
				.querySelector( "input[ name = 'spaRoute' ]" )
				.value = window.location.hash.slice( 1 ) // Strip off leading pound.
			;

		</script>

	</body>
	</html>

</cfoutput>
