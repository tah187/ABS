<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="ABS._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <h2>
        Welcome to the Appointment Booking System
    </h2>
    <p>
        The Appointment Booking Systems allows you to quickly book your favourite Conference Room. 
    </p>
    <p>
        Before you can use this application, you need to have an active account. If you dont have an active account you can 
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Account/Register.aspx">create one now.</asp:HyperLink>
    </p>
    <p>
        Otherwise you will be asked to login before you can make an appointment.
    </p>
    <br />
    <p>
        Proceed to
        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="~/Members/Make_Appointment.aspx">make an appointment</asp:HyperLink>
        , or look at the
        <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="~/Check_Availability.aspx">Avalability Checker</asp:HyperLink> 
        to see if your favourite Conference Room is available.
    </p>
</asp:Content>
