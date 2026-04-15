using Microsoft.AspNetCore.Mvc;
using SopranosDashboard.Models;
using MySql.Data.MySqlClient;
using System.Data.SqlTypes;
using Mysqlx.Crud;
using Org.BouncyCastle.Asn1.X509;
namespace SopranosDashboard.Controllers;

public class  CollectionController : Controller
{
    private string _connectionstring = "server=localhost;database=sopranos;user=root;password=;";

    private MySqlConnection connectionHelper()
    {
        MySqlConnection connection = new(_connectionstring);
        connection.Open();
        return connection;
    }

    public IActionResult CashPickup(string targetDate)
    {
        List<CollectionLog> logs = new List<CollectionLog>();

        try
        {
            using (var connection = connectionHelper())
            {
                string sql = "SELECT CollectionLog.Id, Mobster.`FirstName` AS MobsterFirstName, `Mobster`.`LastName` AS MobsterLastName, `CollectionLog`.`DateCollected`, `BusinessFront`.`Name` AS FrontName, `Amount` FROM `CollectionLog` INNER JOIN `BusinessFront` ON `BusinessFront`.id = `CollectionLog`.`BusinessID` INNER JOIN `Mobster` ON `Mobster`.id = `CollectionLog`.`MobsterID` WHERE `DateCollected` = @targetDate;";

                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@targetDate", targetDate);

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            CollectionLog log = new CollectionLog
                            {
                                Id = reader.GetInt32("Id"),
                                Amount = reader.GetFloat("Amount"),
                                DateCollected = reader.GetDateTime("DateCollected"),
                                MobsterFirstName = reader.GetString("MobsterFirstName"),
                                MobsterLastName = reader.GetString("MobsterLastName"),
                                FrontName = reader.GetString("FrontName")
                            };

                            logs.Add(log);
                        }
                    }
                }
            }
        } 
        catch (MySqlException error)
        {
            Console.WriteLine($"Error: {error}");
        }

        return View(logs);
    }
}
    