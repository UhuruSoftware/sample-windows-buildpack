Sample Windows Buildpack
=======================

This sample buildpack allows you to schedule Windows applications in a Cloud Foundry cloud.

You push your application, and next to it you provide a schedule.xml file (you can generate it using Windows Scheduled Tasks).

For more information on the XML schema, follow this   [link](http://msdn.microsoft.com/en-us/library/windows/desktop/aa383609(v=vs.85)).

Your xml file should contain the name of the file you want to run (i.e. my_command.exe). The buildpack will take care of setting the right path for the exe, and it will also set the working directory to the location of the app.