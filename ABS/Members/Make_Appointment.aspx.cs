using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Data.SqlClient;


namespace ABS.Members
{
			public partial class Make_Appointment : System.Web.UI.Page
			{

						protected void Page_Init(object sender, EventArgs e)
						{
									TimeSpan startTime = new TimeSpan(7, 0, 0);
									TimeSpan increment = new TimeSpan(1, 0, 0);
									TimeSpan[] timeList = new TimeSpan[14];

									//populate array with times incremented by an hour
									for (int i = 0; i <= 13; i++)
									{
												timeList[i] = startTime;
												startTime = startTime.Add(increment);
									}


									startTimeDDL.DataSource = timeList;
									startTimeDDL.DataBind();
						}

						protected void Page_Load(object sender, EventArgs e)
						{

									if (!Page.IsPostBack)
									{
												String time = Request.QueryString["time"];

												//If GET values exist, bypass wizard steps
												if (time != null)
												{
															DateTime t = DateTime.Parse(time);
															Session["bookingObject"] = Request.QueryString["room"];
															Calendar1.SelectedDate = t;
															startTimeDDL.SelectedValue = t.TimeOfDay.ToString();

															Wizard1.ActiveStepIndex = 4;
												}
									}
									
						}
						
						protected void SelectRoom_OnSelectedIndexChanged (Object sender, EventArgs e)
						{
									//Set Room Id
									int rowIndex = SelectRoom.SelectedIndex;
									Session["bookingObject"] = SelectRoom.DataKeys[rowIndex].Value;
									//Next Step
									Wizard1.ActiveStepIndex++;
						}

						protected void Calendar_Selection_Change(Object sender, EventArgs e)
						{
									//Next Step
									Wizard1.ActiveStepIndex++;
						}

						protected void OnButtonClick(object sender, WizardNavigationEventArgs e)
						{

						}

						protected void OnFinishButtonClick(object sender, WizardNavigationEventArgs e)
						{
									BookingSystem bs = new BookingSystem();
									Appointment appointment = new Appointment();
									
									//Set current user values
									appointment.username = this.User.Identity.Name;
									MembershipUser user = Membership.GetUser(appointment.username);
									if (user != null)
									{
												appointment.email = user.Email;
									}
									Int32 BookingObjectId = Convert.ToInt32(Session["bookingObject"]);
									DateTime StartTime = Calendar1.SelectedDate.Date.Add(TimeSpan.Parse(startTimeDDL.SelectedItem.Text));
									//Set form values
									appointment.bookingObject = BookingObjectId;
									appointment.startDate = StartTime;
									appointment.endDate = appointment.startDate.Add(bs.AppointmentLength);
									appointment.comments = Comments.Text;
					
									Int32 rowReturned = 0;

									DataTable days = bs.GetBookingObjectWorkingDays(BookingObjectId);
									DataTable BookingObjects = bs.GetBookingObjects(BookingObjectId);
									DataRow row = BookingObjects.Rows[0];
									DateTime openTime = DateTime.Parse(row["StartTime"].ToString());
									DateTime closeTime = DateTime.Parse(row["EndTime"].ToString());


									//Check to See Room is open
									if (!bs.RoomClosed(BookingObjectId, StartTime, openTime.TimeOfDay,
												closeTime.TimeOfDay, days))
									{
												//Check for Existing Booking
												if (bs.RoomBooked(appointment.bookingObject, appointment.startDate))
												{
															rowReturned = bs.AddAppointment(appointment);
												}
									}

									if (rowReturned == 1)
									{
												Error.Text = "Appointment Succesfully Added.";
									} else {
												Error.Text = "Error adding row.";
									}

						}
			}
}