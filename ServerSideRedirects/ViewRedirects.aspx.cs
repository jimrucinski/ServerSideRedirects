using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Xsl;

using System.IO;


namespace ServerSideRedirects
{
    public partial class ViewRedirects : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            
            //loadXML();
        }
        protected void loadXML()
        {
            /*
            XmlDocument xdoc = new XmlDocument();
            xdoc.Load(Server.MapPath("redirects.config"));
            XmlNode xnode = xdoc.CreateNode("element", "Redirects", "");
            xnode.InnerText = "";
            XslTransform xsl = new XslTransform();
            xsl.Load(Server.MapPath("/Style/redirects.xsl"));
            X1.Document = xdoc;
            X1.Transform = xsl;
             * */

        }
    }
}