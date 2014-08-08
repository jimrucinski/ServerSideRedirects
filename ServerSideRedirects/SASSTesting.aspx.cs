using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;

namespace ServerSideRedirects
{
    public partial class SASSTesting : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using(var client = new MyClient()) {
                client.HeadOnly = true;
                // fine, no content downloaded
                try{
                string s1 = client.DownloadString("http://google.com");
                }
                catch(Exception ex)
                {
                    
                }
                // throws 404
                try{
                string s2 = client.DownloadString("http://google.com/silly");
                }
                catch(Exception ex)
                {
                    Response.Write(ex.Message);
                }
            }
        }
    }
    class MyClient : WebClient
    {
        public bool HeadOnly { get; set; }
        protected override WebRequest GetWebRequest(Uri address)
        {
            WebRequest req = base.GetWebRequest(address);
            if (HeadOnly && req.Method == "GET")
            {
                req.Method = "HEAD";
            }
            return req;
        }
    }
}