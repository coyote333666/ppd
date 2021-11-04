# ppd - PHP Putty deployment

Dos and powershell scripts for batch deployment of PHP files with the putty utility for secure file transfers (psftp)

Requirements
------------

  * psftp - putty utility - Windows Client side;
  * powershell -  Windows Client side;

1) In the header of modified files, in the creation or modification section,
indicate the batch id. This string may be date of modification and the initials of the developer separated by the
underscore and followed by a sequential number (the number
sequential is optional), for example: 2020-07-31_VF_01. It's this batch id
which is reported in the header deployment script. Research on the
application directory for files containing this batch identifier allows
to select the files to deploy. In fact, any chain of character used one or more times in the file to be deployed
will work, but it is recommended to use this standard.

2) From DOS Shell, we run the following commands to generate the
DOS batch files using secure transfer with the psftp utility
by putty, then, we execute:

```bash
gen_deployment.bat
deployment.bat
```

3) If necessary, backtrack by executing the ROLLBACK : script_ROLLBACK.scr. 
The .bak files on the server always match the version before the last deployment. 