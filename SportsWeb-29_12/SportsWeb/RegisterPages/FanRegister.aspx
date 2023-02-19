<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FanRegister.aspx.cs" Inherits="SportsWeb.RegisterPages.FanRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Register Fan</h2>
        <table>
            <tr>
                <td>Name</td>
                <td><asp:TextBox ID="nameText" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Username</td>
                <td><asp:TextBox ID="usernameText" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Password</td>
                <td>
                    <input type="password" name="passwordText" /></td>
            </tr>
            <tr>
                <td>National ID</td>
                <td><asp:TextBox ID="nationalIDText" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Phone No.</td>
                <td><input type="tel" id="phone" name="phoneText" /></td>
            </tr>
            <tr>
                <td>Birth Date</td>
                <td><input type="date" id="date" name="bdateText" /></td>
            </tr>
            <tr>
                <td>Address</td>
                <td><asp:TextBox ID="addressText" runat="server"></asp:TextBox></td>
            </tr>
        </table>
        <br />
        <asp:Button ID="regBtn" runat="server" Text="Register" OnClick="Register" />
    </form>
</body>
</html>
