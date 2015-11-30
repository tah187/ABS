using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ABS
{
			public partial class Check_Availability : System.Web.UI.Page
			{

						protected void Page_Load(object sender, EventArgs e)
						{
	

						}

						protected void Calendar_Change(Object sender, EventArgs e)
						{
									DateSelected.Text = "You selected: " +
												Calendar1.SelectedDate.ToString("dd/MM/yyyy HH:mm");
									BuildTable();
						}

						protected void BuildTable()
						{
									BookingSystem bs = new BookingSystem();

									DateTime date = Calendar1.SelectedDate;

									DataTable Appointments = bs.GetAppointmentsByDate(date);
									DataTable BookingObjects = bs.GetBookingObjects();

									// First row in table.
									TableRow row = new TableRow();
									TableCell cell = new TableCell();

									cell.Text = "Conference Room";
									row.Cells.Add(cell);

									for (int i = 0; i < BookingSystem.HoursOpen; i++)
									{
												cell = new TableCell();
												cell.Text = (BookingSystem.StartTime + i).ToString();
												row.Cells.Add(cell);
									}

									BookingTable.Rows.Add(row);

									// Data rows in table

									foreach (DataRow r in BookingObjects.Rows)
									{
												row = new TableRow();

												//Room Titles
												cell = new TableCell();
												cell.Text = r["Title"].ToString();
												row.Cells.Add(cell);

												//Room ID
												int room = Convert.ToInt32(r["Id"]);

												//Opening and closing times of Booking Object
												TimeSpan openTime = DateTime.Parse(r["StartTime"].ToString()).TimeOfDay;
												TimeSpan closeTime = DateTime.Parse(r["EndTime"].ToString()).TimeOfDay;
												
												//Opening Days
												DataTable days = bs.GetBookingObjectWorkingDays(room);

												//Room Availabilites
												for (int i = 0; i < BookingSystem.HoursOpen; i++)
												{
															cell = new TableCell();
															
															DateTime time = Calendar1.SelectedDate.Date.Add(new TimeSpan(i + BookingSystem.StartTime, 0, 0));

															bool closed = bs.RoomClosed(room, time, openTime, closeTime, days);


															if (bs.RoomBooked(room, time, Appointments) || closed )
															{
																		cell.Style.Add("background-color", "#353535");
															}
															else
															{
																		cell.Style.Add("background-color", "lightgrey");

																		HyperLink link = new HyperLink();
																		link.Text = "Book";
																		link.NavigateUrl =
																						"~/Members/Make_Appointment.aspx?room=" + room +
																						"&time=" + time.ToString("dd/MM/yyyy HH:mm");

																		cell.Controls.Add(link);
															}

															row.Cells.Add(cell);


												}

												BookingTable.Rows.Add(row);
									}
						}

			}
}