<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="SportsWeb.Fan" EnableEventValidation="false" ValidateRequest="false" %>

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

    body {
        font: verdana;
        font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
        justify-content: center;
        align-items: center;
        text-align: center;
        display: flex
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
    }

    .myGridStyle tr:nth-child(odd) {
        background-color: #f8fafa;
        
    }

    .myGridStyle td {
        border: 1px solid black;
        padding: 8px;
    }
    .myGridStyle tr:last-child td {
    }

</style>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td>
                    <h3>Available Matches</h3>
                </td>
            </tr>
            <tr>
                <td>
                    <input type="datetime-local" id="dateText" name="dateText" />
                    <asp:Button ID="availMatchesBtn" runat="server" Text="View" OnClick="availMatchesBtn_Click" />
                </td>
            </tr>
            <tr>
                <td style="justify-content: center; display: flex">
                    <asp:GridView class="myGridStyle" ID="gvAvailMatches" runat="server" AutoGenerateColumns="False" CellPadding="4" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="Host" HeaderText="Host Club" />
                            <asp:BoundField DataField="Guest" HeaderText="Guest Club" />
                            <asp:BoundField DataField="StadName" HeaderText="Stadium" />
                            <asp:BoundField DataField="Location" HeaderText="Location" />
                            <asp:BoundField DataField="number" HeaderText="Available Tickets" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="purchaseBtn" runat="server" Text="Purchase" CommandArgument='<%# Eval("Host")+ ";" +Eval("Guest") + ";" +Eval("start_time")%>' OnClick="purchaseBtn_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
