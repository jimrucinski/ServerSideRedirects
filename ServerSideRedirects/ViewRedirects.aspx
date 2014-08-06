<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewRedirects.aspx.cs" Inherits="ServerSideRedirects.ViewRedirects" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Xml runat="server" ID="X1" DocumentSource="~/redirects.config" TransformSource="Style/redirects.xsl"/>
    </div>
    </form>
</body>
</html>
