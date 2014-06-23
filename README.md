docker-nginx-aspnet
==================

A minimal CentOS 6.4 install based on Docker's official image with mono and nginx installed to serve a sample ASP.NET application.

At the moment this package serves as an example of putting these tools together and should not be used in production.

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

* Use an init script for fastcgi-mono-server
* Run nginx using the Dockerfile CMD command to run the container as a daemon
* Use more sensible paths for everything (ie. support multiple applications)
* Secure installations and runtime environments
* Provide easy methods to maintain registered ASP.NET applications (nginx & fastcgi-mono-server configs)
* Optimize configs with nice defaults
* Investigate building mono using minimal flags to reduce output size - right now the entire image is 1GB, the base CentOS image is 300MB with mono consuming most of the rest

Notes on mono & ASP.NET
==================

The current build of mono used does not support ASP.NET MVC5.

The only special consideration for deploying MVC4 applications is removing the Microsoft.Web.Infrastructure.dll file from the bin directory after deployment, or not include it in deployment at all. Though it may be required for deployment to IIS.

Keeping my eye on [mono/mono PR#888](https://github.com/mono/mono/pull/888) which should bring some MVC5 support.

Other notes
==================

The HelloWorldMvc4 source code included is just the default ASP.NET MVC4 application (.NET Framework 4.0) from Visual Studio. I have simply removed authentication and Entity Framework as it is not compatible with mono. 

Site.css has been renamed to site.css due to the default BundleConfig referring to the file in lowercase which matters in Linux but no Windows.

If you want to build HelloWorldMvc4 for some reason, you will need to enable NuGet package restore on it as I haven't included the packages directory.