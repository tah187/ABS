using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace ABS
{
			public class BookingSystem
			{
						public const int StartTime = 7;
						public const int EndTime = 21;
						public const int HoursOpen = EndTime - StartTime;
						public TimeSpan AppointmentLength = new TimeSpan(1, 0, 0);
						public TimeSpan HourIncrement = new TimeSpan(1, 0, 0);

						public string ABSConnention = System.Configuration.ConfigurationManager.ConnectionStrings["ABSConnectionString"].ToString();

						public BookingSystem ()
						{

						}

						public DataTable GetAppointmentsByDate(DateTime date)
						{
									DataTable dataTable = new DataTable(); 
									if (date.Year != 1)
									{
												DateTime start = date.Date.Add(new TimeSpan(0,0,0));
												DateTime end = date.Date.Add(new TimeSpan(23,59,59));
									
												//open database to collect item
												SqlConnection conn = new SqlConnection(ABSConnention);
												SqlCommand cmd = new SqlCommand("dbo.GetAppointments", conn);
												cmd.CommandType = CommandType.StoredProcedure;
												cmd.Parameters.AddWithValue("@StartDate", start);
												cmd.Parameters.AddWithValue("@EndDate", end);
												conn.Open();
												// create data adapter
												SqlDataAdapter da = new SqlDataAdapter(cmd);
												//Fill Table
												da.Fill(dataTable);
												conn.Close();
									}

									return dataTable;
						}

						public DataTable GetBookingObjects()
						{
									SqlConnection conn = new SqlConnection(ABSConnention);
									SqlCommand cmd = new SqlCommand("SELECT * FROM BookingObject", conn);
									SqlDataAdapter da = new SqlDataAdapter(cmd);
									DataTable BookingObjects = new DataTable();
									conn.Open();
									da.Fill(BookingObjects);
									conn.Close();
									return BookingObjects;
						}

						public DataTable GetBookingObjects(int BookingObjectId)
						{
									SqlConnection conn = new SqlConnection(ABSConnention);
									SqlCommand cmd = new SqlCommand("SELECT * FROM BookingObject WHERE Id = @BookingObjectId", conn);
									cmd.Parameters.AddWithValue("@BookingObjectId", BookingObjectId);
									SqlDataAdapter da = new SqlDataAdapter(cmd);
									DataTable BookingObjects = new DataTable();
									conn.Open();
									da.Fill(BookingObjects);
									conn.Close();
									return BookingObjects;
						}

						public DataTable GetBookingObjectWorkingDays (int BookingObjectId)
						{
									SqlConnection conn = new SqlConnection(ABSConnention);
									SqlCommand cmd = new SqlCommand("dbo.WorkingDays", conn);
									cmd.CommandType = CommandType.StoredProcedure;
									cmd.Parameters.AddWithValue("@BookingObjectId", BookingObjectId);
									SqlDataAdapter da = new SqlDataAdapter(cmd);
									DataTable WorkingDays = new DataTable();
									conn.Open();
									da.Fill(WorkingDays);
									conn.Close();
									return WorkingDays;
						}

						public bool RoomClosed(int BookingObjectId, DateTime time, TimeSpan openTime, TimeSpan closeTime, DataTable days)
						{
									bool closed;
									bool pastdate = true;

									//search opening days, count will be 1 if open that day
									int count = 0;
									foreach (DataRow dayrow in days.Rows)
									{
												if (time.DayOfWeek.ToString() == dayrow["Description"].ToString())
												{
															count++;
												}
									}

									if (time.TimeOfDay >= openTime && time.TimeOfDay < closeTime && count == 1)
									{
												closed = false;
									}
									else
									{
												closed = true;
									}

									//Check date is not in the past
									if (DateTime.Compare(time.Date, DateTime.Now.Date) >= 0)
									{
												pastdate = false;
									}

									if (closed || pastdate)
									{
												return true;
									} else {
												return false;
									}
						}

						public bool RoomBooked (int BookingObjectId, DateTime time, DataTable Appointments)
						{
									foreach (DataRow row in Appointments.Rows)
									{
												if (BookingObjectId == Convert.ToInt32(row["BookingObjectId"]) && time == DateTime.Parse(row["StartDate"].ToString())) return true;
									}
									return false;
						}

						public bool RoomBooked (int BookingObjectId, DateTime time)
						{
									//open database to check for item
									SqlConnection conn = new SqlConnection(ABSConnention);
									SqlCommand cmd = new SqlCommand("dbo.RoomBooked", conn);
									cmd.CommandType = CommandType.StoredProcedure;
									cmd.Parameters.AddWithValue("@BookingObjectId", BookingObjectId);
								 cmd.Parameters.AddWithValue("@StartDate", time.ToString("yyyy-MM-dd HH:mm:ss"));

									conn.Open();
									Int32 rowsAffected;
									rowsAffected = cmd.ExecuteNonQuery();
									conn.Close();
									//If a row is returned, item already exists
									if (rowsAffected >= 1)
									{
												return false; //Appointment Exists
									} else {
												return true;
									}
									
						}

						public Int32 AddAppointment (Appointment appointment)
						{
									SqlConnection conn = new SqlConnection(ABSConnention);
									SqlCommand cmd = new SqlCommand("dbo.AddAppointment", conn);
									cmd.CommandType = CommandType.StoredProcedure;
									cmd.Parameters.AddWithValue("@UserName", appointment.username);
									cmd.Parameters.AddWithValue("@Email", appointment.email);
									cmd.Parameters.AddWithValue("@Start", appointment.startDate);
									cmd.Parameters.AddWithValue("@End", appointment.endDate);
									cmd.Parameters.AddWithValue("@Comments", appointment.comments);
									cmd.Parameters.AddWithValue("@BookingObjectId", appointment.bookingObject);
									
									conn.Open();
									Int32 rowsAffected;
									rowsAffected = cmd.ExecuteNonQuery();

									return rowsAffected;
						}


			}






}