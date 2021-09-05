
# Maintaining Route Information During SPA Authentication In Lucee CFML

This is a small exploration that looks at the challenges of maintaining route information during a SPA (Single-Page Application) authentication workflow in a Lucee CFML application. This requires passing some sort or "redirect" value around from page-to-page and then forwarding the user to that redirect after they have logged-in. The login workflow may or may not include external services, such as Single Sign-On (SSO) providers that are out of our control.
