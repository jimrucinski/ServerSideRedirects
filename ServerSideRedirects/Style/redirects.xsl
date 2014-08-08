<?xml version="1.0" encoding="utf-8"?>

  <xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" xmlns:ClassNameHere="dummy namespace here">
  <msxsl:script language="C#" implements-prefix="ClassNameHere">

    <![CDATA[


        public string MethodName(/* some parameters here*/)

        {

              using(var client = new MyClient()) {
                client.HeadOnly = true;
                // fine, no content downloaded
                try{
                string s1 = client.DownloadString("http:///google.com");
                }
                catch(Exception ex)
                {
                    
                }
                // throws 404
                try{
                string s2 = client.DownloadString("http:///google.com/silly");
                }
                catch(Exception ex)
                {
                    //return "error";
                }
                return "ok";
            }
        }
 class MyClient : System.Net.WebClient
    {
        public bool HeadOnly { get; set; }
        protected override System.Net.WebRequest GetWebRequest(Uri address)
        {
            System.Net.WebRequest req = base.GetWebRequest(address);
            if (HeadOnly && req.Method == "GET")
            {
                req.Method = "HEAD";
            }
            return req;
        }
        }

    ]]>

  </msxsl:script>
  
  <xsl:output method="html" indent="yes"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta name="viewport" content="width=device-width"></meta>
        <link href="./style/Scss1.css" rel="stylesheet" />
      </head>
      <body>
        <table>
          <tr>
            <th>Rule Name</th>
            <th>Stop Processing</th>
            <th>Pattern</th>            
            <th>Match URL</th>
            <th>Entered URL</th>
            <th>Action URL</th>
            <th>Action Type</th>
          </tr>
          <xsl:for-each select="rules/rule" >
            <tr>
              <xsl:attribute name="id">
                <xsl:if test="./match/@url = '^(.*)'"><xsl:text>highlight</xsl:text></xsl:if>
              </xsl:attribute>
              <td>
                <xsl:value-of select="ClassNameHere:MethodName()"/>
              </td>
              <td>
                <xsl:value-of select="@name"/>
              </td>
              <td>
                <xsl:value-of select="@stopProcessing"/>
              </td>
              <td>
                <xsl:value-of select="./conditions/add/@pattern"/>
              </td>              
              <td>
                <xsl:value-of select ="./match/@url"/>
              </td>
              <td>
                <xsl:variable name="Pattern" select ="./conditions/add/@pattern"/>
                <xsl:variable name="match" select="./match/@url" />
                <xsl:choose>
                  <xsl:when test="contains($Pattern,'^(www\.)?')">
                    <xsl:variable name="OptUrl" select="substring-before(substring-after($Pattern,'^(www\.)?'),'$')"/>
                    <a target="new">
                      <xsl:attribute name="href">
                       <xsl:value-of select="./action/@url"/>
                      </xsl:attribute>                      
                      http://www.<xsl:value-of select= '$OptUrl'/>/<xsl:value-of select="substring-after($match,'^')"/>
                    </a>                   
                    <br/>
                    <br/>
                    <a target="new">
                      <xsl:attribute name="href">
                        <xsl:value-of select="./action/@url"/>
                      </xsl:attribute>
                      http://<xsl:value-of select= '$OptUrl'/>/<xsl:value-of select="substring-after($match,'^')"/>
                    </a>
                  </xsl:when>
                  <xsl:otherwise>
                    <a target="new">
                      <xsl:attribute name="href">
                        http://<xsl:value-of select="substring-before(substring-after($Pattern,'^'),'$')"/>/<xsl:value-of select="substring-after($match,'^')"/>
                      </xsl:attribute>
                      <xsl:value-of select="substring-before(substring-after($Pattern,'^'),'$')"/>/<xsl:value-of select="substring-after($match,'^')"/>
                    </a>                    
                  </xsl:otherwise>
                </xsl:choose>
              </td>
              <td>
                <a target="new">
                  <xsl:attribute name="href">
                    <xsl:value-of select="./action/@url"/>
                  </xsl:attribute>
                  <xsl:value-of select="./action/@url"/>
                </a>
              </td>
              <td>
                <xsl:value-of select="./action/@type"/>
              </td>             
            </tr>
          </xsl:for-each>          
        </table>        
      </body>      
    </html>
  </xsl:template>
</xsl:stylesheet>

