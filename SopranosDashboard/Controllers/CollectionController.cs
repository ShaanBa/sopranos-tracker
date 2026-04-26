using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using System;
using SopranosDashboard.Models;
using MySql.Data.MySqlClient;
using System.Data.SqlTypes;
using Mysqlx.Crud;
using Org.BouncyCastle.Asn1.X509;
using Org.BouncyCastle.Math.Field;
namespace SopranosDashboard.Controllers;

public class  CollectionController : Controller
{
    private readonly string _connectionstring;

    public CollectionController(IConfiguration configuration)
    {
        _connectionstring = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Missing connection string: DefaultConnection");
    }

    private MySqlConnection connectionHelper()
    {
        MySqlConnection connection = new(_connectionstring);
        connection.Open();
        return connection;
    }

    public IActionResult CashPickup(string? startDate, string? endDate)
    {
        List<CollectionLog> logs = new List<CollectionLog>();

        try
        {
            using (var connection = connectionHelper())
            {
                string sql = "SELECT CollectionLog.Id, Mobster.`FirstName` AS MobsterFirstName, `Mobster`.`LastName` AS MobsterLastName, `CollectionLog`.`DateCollected`, `BusinessFront`.`Name` AS FrontName, `Amount` FROM `CollectionLog` INNER JOIN `BusinessFront` ON `BusinessFront`.id = `CollectionLog`.`BusinessID` INNER JOIN `Mobster` ON `Mobster`.id = `CollectionLog`.`MobsterID` WHERE (@startDate IS NULL OR DateCollected >= @startDate) AND (@endDate IS NULL OR DateCollected <= @endDate);";
                using (var command = new MySqlCommand(sql, connection))
                {
                    object startParam = string.IsNullOrWhiteSpace(startDate) ? DBNull.Value : startDate;
                    object endParam = string.IsNullOrWhiteSpace(endDate) ? DBNull.Value : endDate;
                    command.Parameters.AddWithValue("@startDate", startParam);
                    command.Parameters.AddWithValue("@endDate", endParam);

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
    