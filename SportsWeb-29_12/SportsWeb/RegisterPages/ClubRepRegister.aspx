<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepRegister.aspx.cs" Inherits="SportsWeb.RegisterPages.ClubRepRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Register Club Representative</h2>
        <table>
            <tr>
                <td>Name</td>
                <td>
                    <asp:TextBox ID="nameText" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Username</td>
                <td>
                    <asp:TextBox ID="usernameText" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Password</td>
                <td>
                    <input type="password" name="passwordText" /></td>
            </tr>
            <tr>
                <td>Club</td>
                <td>
                    <select name="clubSelect" style="width: 168px">
                        <asp:PlaceHolder ID="clubsList" runat="server"></asp:PlaceHolder>
                    </select></td>
            </tr>
        </table>
        <br />
        <asp:Button ID="regBtn" runat="server" Text="Register" OnClick="Register" />
    </form>
</body>
</html>
