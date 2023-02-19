<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepRegister.aspx.cs" Inherits="SportsWeb.RegisterPages.ClubRepRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
    <style>
    table, th, td {
        /*        border: 1px solid black;*/
        text-align: center;
    }
    #bg {
        background-image: url('../img/bg.png');
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-size: cover;
        filter: blur(5px);
        border: 1px solid red;

        z-index:-100;
    }

    body {
        font: verdana;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        justify-content: center;
        align-items: center;
        text-align: center;
        display: flex;
        color: white;
    }

    .myGridStyle {
        border-collapse: collapse;
    }
    .myGridStyle tr th {
        padding: 8px;
        color: white;
        border: 1px solid black;
        background-color: #1C5E55;
    }

    .myGridStyle tr:nth-child(even) {
            background-color: #E3EAEB;
            color: black;
        }

        .myGridStyle tr:nth-child(odd) {
            background-color: #f8fafa;
            color: black;
        }

    .myGridStyle td {
        border: 1px solid black;
        padding: 8px;
    }
    .myGridStyle tr:last-child td {
    }

</style>
<body>
    <div id="bg"></div>
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
