<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SportsWeb.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<style>
    @import url("https://fonts.googleapis.com/css?family=Lato:400,700");

    #bg {
        background-image: url('img/bg.png');
        position: fixed;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-size: cover;
        filter: blur(5px);
    }

    body {
        font-family: 'Lato', sans-serif;
        color: #4A4A4A;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        overflow: hidden;
        margin: 0;
        padding: 0;
    }

    form {
        width: 350px;
        position: relative;
        padding: 0;
        margin:0;
        height: 200px;

    }

        form .form-field::before {
            font-size: 20px;
            position: absolute;
            left: 15px;
            top: 17px;
            color: #888888;
            content: " ";
            display: block;
            background-size: cover;
            background-repeat: no-repeat;
        }

        form .form-field:nth-child(1)::before {
            background-image: url(img/user-icon.png);
            width: 20px;
            height: 20px;
            top: 15px;
        }

        form .form-field:nth-child(2)::before {
            background-image: url(img/lock-icon.png);
            width: 16px;
            height: 16px;
        }

        form .form-field {
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-pack: justify;
            -ms-flex-pack: justify;
            justify-content: space-between;
            -webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;
            margin-bottom: 1rem;
            position: relative;
        }

        form input {
            font-family: inherit;
            width: 100%;
            outline: none;
            background-color: #fff;
            border-radius: 4px;
            border: none;
            display: block;
            padding: 0.9rem 0.7rem;
            box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16);
            font-size: 20px;
            color: #4A4A4A;
            text-indent: 40px;
        }

        form .btn {
            outline: none;
            border: none;
            cursor: pointer;
            display: inline-block;
            margin: auto;
            /*padding: 0.9rem 2.5rem;*/
            text-align: center;
            line-height: 0px;
            background-color: #47AB11;
            color: #fff;
            border-radius: 4px;
            box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.16);
            font-size: 17px;
            width:70%;
            height:40px;

        }
        .reg{
            margin: auto;
            padding-top: 20px;
            color: ghostwhite;
            text-decoration: none;
        }
</style>
<body>
    <div id="bg"></div>
    <form id="form1" runat="server">
        <%--<table>
            <tr>
                <h2>Login</h2>
            </tr>
            <tr>
                <td>Username</td>
                <td>
                    <asp:TextBox ID="usernameInput" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Password</td>
                <td>
                    <input type="password" name="passwordInput" /></td>
            </tr>
        </table>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="loginUser" Style="height: 29px" />
        </p>
        <a href="Register.aspx">Register</a>--%>





        <div class="form-field">
            <asp:TextBox ID="usernameInput" runat="server" ToolTip="Username"></asp:TextBox></td>
<%--            <input type="text" placeholder="Username" id="usernameInput" />--%>
        </div>

        <div class="form-field">
            <input type="password" placeholder="Password" name="passwordInput" />
        </div>

        <div class="form-field" style="margin-bottom:0;">
            <asp:Button CssClass="btn" ID="Button1" runat="server" Text="Login           " OnClick="loginUser" />
        </div>
        <div class="form-field" style="text-align:center">
            <a class="reg" href="Register.aspx">Register</a>
        </div>
    </form>
</body>
</html>
