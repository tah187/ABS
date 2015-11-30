<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Make_Appointment.aspx.cs" Inherits="ABS.Members.Make_Appointment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Conference Room Selection Wizard</h2>
    <p><asp:Label ID="Error" runat="server" Text="..."></asp:Label></p>

    <asp:Wizard ID="Wizard1" runat="server" 
    OnNextButtonClick="OnButtonClick" OnPreviousButtonClick="OnButtonClick"
    OnFinishButtonClick="OnFinishButtonClick" ActiveStepIndex="0" Height="252px" 
        Width="653px"   >
    <StepNavigationTemplate>
        <asp:Button ID="StepPreviousButton" runat="server" CausesValidation="False"
            CommandName="MovePrevious" Text="Previous" Visible="True" />
        <asp:Button ID="StepNextButton" runat="server" CommandName="MoveNext"
            Text="Next" Visible="True"/>
    </StepNavigationTemplate>
        <WizardSteps>
            <asp:WizardStep ID="WizardStep1" runat="server" title="Introduction">
                <p>Welcome to the Conference Room Selection Wizard. This wizard will guide you through the process of making an appointment. Click Nect to continue.</p>
                
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep2" runat="server" title="Select a Conference Room">

                <asp:GridView ID="SelectRoom" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="Id" DataSourceID="BookingObjects" 
                    OnSelectedIndexChanged="SelectRoom_OnSelectedIndexChanged" Width="380px">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                        <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" 
                            ReadOnly="True" SortExpression="Id" Visible="False" />
                         <asp:CommandField ShowSelectButton="True" />
                   </Columns>
                </asp:GridView>

                <p>You Selected: <asp:Label ID="RoomSelection" runat="server" Text=""></asp:Label></p>

                <asp:SqlDataSource ID="BookingObjects" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ABSConnectionString %>" 
                    SelectCommand="SELECT [Id], [Title] FROM [BookingObject]"></asp:SqlDataSource>

            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep3" runat="server" title="Select Date">
                <asp:Calendar ID="Calendar1" runat="server" 
                    onSelectionChanged="Calendar_Selection_Change"
                    BackColor="#FFFFCC" 
                    BorderColor="#FFCC66" BorderWidth="1px" DayNameFormat="Shortest" 
                    Font-Names="Verdana" Font-Size="8pt" ForeColor="#663399" Height="200px" 
                    ShowGridLines="True" Width="220px">
                    <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                    <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                    <OtherMonthDayStyle ForeColor="#CC9966" />
                    <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                    <SelectorStyle BackColor="#FFCC66" />
                    <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" 
                        ForeColor="#FFFFCC" />
                    <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                </asp:Calendar>
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep4" runat="server" title="Select Time">
                <p>Select a Time:
                    <asp:DropDownList ID="startTimeDDL" runat="server">                      
                    </asp:DropDownList>              
                </p>
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep5" runat="server" title="Comments">
                <p>Add additional comments:</p>
                <asp:TextBox ID="Comments" runat="server" Height="10.2em" Width="36.4em" 
                    style="margin-left: 0px" TextMode="MultiLine"></asp:TextBox>
            </asp:WizardStep>
            <asp:WizardStep ID="WizardStep6" runat="server" title="Review Your Request">
            </asp:WizardStep>
        </WizardSteps>
    </asp:Wizard>
</asp:Content>
