component
	output = false
	hint = "I define the application settings and event-handlers."
	{

	// Configure the application.
	this.name = "SpaHashDemo";
	this.applicationTimeout = createTimeSpan( 0, 1, 0, 0 );
	this.sessionManagement = true;
	this.sessionTimeout = createTimeSpan( 0, 1, 0, 0 );

	// ---
	// LIFE-CYCLE METHODS.
	// ---

	/**
	* I get called once when the session is being initialized.
	*/
	public void function onSessionStart() {

		session.isLoggedIn = false;

	}


	/**
	* I get called once as the top of each incoming CFML request.
	*/
	public void function onRequestStart() {

		// To make request management easier, let's combine the URL and FORM scopes into
		// a single struct (with the POST/FORM values taking highest precedence). This is
		// similar to the "request context" that gets used in other ColdFusion frameworks.
		request
			.append( url )
			.append( form )
		;

	}

}
