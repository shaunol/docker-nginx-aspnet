docker-nginx-aspnet
==================

A minimal CentOS 6.4 install based on Docker's official image with mono and nginx installed to serve a sample ASP.NET application.

This should just serve as an example of putting these tools together and not be used in production.

Usage
==================

Start the container:
`docker run -t -i -p 80:80 shaunol/nginx-aspnet /bin/bash`

Once inside the containers' shell:

Start fastcgi-mono-server: 
`/usr/bin/fastcgi-mono-server4 /applications=/:/usr/aspnet/ /socket=tcp:127.0.0.1:9000 &`

Start nginx:
`/usr/sbin/nginx`

You should now be able to access the ASP.NET MVC4 sample page via http://docker-container-ip/

TODO
==================

It would be nice if this were actually able to be used in production.

* Start fastcgi-mono-server and nginx automatically
* Issue a CMD in the Dockerfile to easily run the container as a daemon
* Sensible paths for everything (ie. support multiple applications)
* Secure installations and runtime environments
* Easy methods to maintain registered ASP.NET applications (nginx & fastcgi-mono-server configs)
* Optimize configs with nice defaults
* Possibly port to Ubuntu, I'm not sure CentOS gets the same love on Docker as Ubuntu does, so it may be more lightweight and updated more often

Notes on mono & ASP.NET
==================

The current build of mono used does not support ASP.NET MVC5.

The only special consideration for deploying MVC4 applications, is to remove the Microsoft.Web.Infrastructure.dll folder from the bin directory after deployment, or not include it in deployment at all. Though it may be required for deployment to IIS.

Keeping my eye on [mono/mono PR#888](https://github.com/mono/mono/pull/888) which should bring some MVC5 support.

Other notes
==================

The HelloWorldMVC source code included is just the default ASP.NET MVC4 application (.NET Framework 4.0) from Visual Studio. I have simply removed all authentication and Entity Framework (it is not compatible with mono) code. 

I have also renamed Site.css to site.css because the default BundleConfig refers to the file in lowercase which doesn't usually matter in a Windows environment. 

If you want to build this solution, you will need to enable NuGet package restore on the solution as I haven't included the packages directory.