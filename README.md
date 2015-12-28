# wFuzzParser

Script which parses the output from wfuzz tool.

Output: 
$httpCodeUrlList.txt --> Url constructed from the following $httpCode
processed_$httpCodeCodes.txt --> Raw response from wfuzz to $httpCode

@TODO Extract $target correctly 

@TODO ¿Launch wfuzz?

@TODO Usage

@TODO Friendly result files


Note: In some cases (E. Kali Linux) Wfuzz needs to be edited in order to work properly:

"In reqresp.py (lines 350 and 391), SSL_VERIFYHOST is set to 1, which is not supported anymore"
Change the 1 to 0 on both line 350 and 391 and it works again.

Source: https://bbs.archlinux.org/viewtopic.php?id=178605
