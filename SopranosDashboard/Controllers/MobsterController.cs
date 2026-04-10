namespace SopranosDashboard.Controllers;
using SopranosDashboard.Models;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.VisualBasic;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using Org.BouncyCastle.Asn1.Cmp;
using SopranosDashboard.Controllers;

public class MobsterController : Controller // tells c# class our mobster controller inherits functionality from base controller
{
    public IActionResult Search(string searchTerm)
    {
        string connectionstring = "server=localhost;database=sopranos;user=root;password=;";
        List<Mobster> mobsters = new List<Mobster>();
        using (var connection = new MySqlConnection(connectionstring))
        {
            try
            {
                connection.Open();
                string sql = "SELECT * FROM Mobster WHERE Moniker = @search OR `Rank` = @search OR Status = @search";

                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@search", searchTerm);

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Mobster mobster = new Mobster
                            {
                                FirstName = reader.GetString("FirstName"),
                                LastName = reader.GetString("LastName"),
                                Rank = reader.GetString("Rank"),
                                Status = reader.GetString("Status"),
                                CrewID = reader.GetInt16("CrewID"),
                                Moniker = reader.GetString("Moniker")
                            };
                            mobsters.Add(mobster);
                        }
                    }
                }
            }
            
            catch (MySqlException error) 
            {
                Console.WriteLine($"Error: {error}");
            }
        }
        return View(mobsters);
    }
}