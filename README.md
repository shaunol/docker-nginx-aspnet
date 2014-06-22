docker-nginx-aspnet
==================

A minimal CentOS 6.4 install Docker's official image with mono and nginx installed to serve a sample ASP.NET application.

This should just serve as an example of putting these tools together and not be used in production.

Usage
==================
`docker run -d -p 80:80 shaunol/nginx-aspnet`

You should now be able to access the ASP.NET MVC4 sample page via http://docker-container-ip/

TODO
==================

It would be nice if this were actually able to be used in production.

* Sensible paths for everything (ie. support multiple applications)
* Secure installations and runtime environments
* Easy methods to maintain registered ASP.NET applications (nginx & fastcgi-mono-server configs)
* Optimize configs with nice defaults