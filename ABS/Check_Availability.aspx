<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Check_Availability.aspx.cs" 
Inherits="ABS.Check_Availability" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Check Availability</h2>
        <p>You can use the Availability Checker to see if your favourite Conference Room is available at the date of your choice. Click the Calender icon below and select the date you want for your appointment. You’ll see a list with all the Conference Rooms and an indication of their availability. When the Conference Room is available, you can make an appointment by clicking “Book”.</p>
    <p>
        <asp:Calendar ID="Calendar1" runat="server" 
        onSelectionChanged="Calendar_Change"
        
        BackColor="White" 
            BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" 
            ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" Width="579px">
            <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
            <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" 
                VerticalAlign="Bottom" />
            <OtherMonthDayStyle ForeColor="#999999" />
            <SelectedDayStyle BackColor="#333399" ForeColor="White" />
            <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" 
                Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
            <TodayDayStyle BackColor="#CCCCCC" />
        </asp:Calendar>


    </p>

    <div>
        <asp:Label ID="DateSelected" runat="server" Text="Select Date"></asp:Label>

        <asp:Table ID="BookingTable" runat="server" Width="578px"></asp:Table>

    </div>
    






</asp:Content>
