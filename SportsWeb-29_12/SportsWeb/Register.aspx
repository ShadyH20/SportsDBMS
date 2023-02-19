<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SportsWeb.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
        <asp:DropDownList ID="userDropDown" runat="server">
            <asp:ListItem>Choose a User Type</asp:ListItem>
            <asp:ListItem>Sports Association Manager</asp:ListItem>
            <asp:ListItem>Club Representative</asp:ListItem>
            <asp:ListItem>Stadium Manager</asp:ListItem>
            <asp:ListItem>Fan</asp:ListItem>
        </asp:DropDownList>
        <p>
            <asp:Button ID="registerBtn" runat="server" Text="Register" OnClick="registerBtn_Click" />
        </p>
    </form>
</body>
</html>
