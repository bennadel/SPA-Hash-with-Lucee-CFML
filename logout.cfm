<cfscript>

	session.isLoggedIn = false;
	location( url = "./index.cfm", addToken = false );

</cfscript>
