using Microsoft.AspNetCore.Mvc;
using SopranosDashboard.Models;
using MySql.Data.MySqlClient;
using System.Runtime.CompilerServices;

namespace SopranosDashboard.Controllers;

public class CrewController : Controller 
{
    private string _connectionstring = "server=localhost;database=sopranos;user=root;password=;";

    private MySqlConnection connectionHelper()
    {
        MySqlConnection connection = new(_connectionstring);
        connection.Open();
        return connection;
    }

    public IActionResult Index()
    {
        List<Crew> crews = new List<Crew>();

        try
        {
            using (var connection = connectionHelper())
            {
                string sql = "SELECT Crew.Name, Crew.id, Crew.Capo, sum(Amount) AS AmtCollected FROM CollectionLog INNER JOIN Mobster on CollectionLog.MobsterID = Mobster.id INNER JOIN Crew on Mobster.CrewID = Crew.id GROUP BY Crew.Name, Crew.id, Crew.Capo;";

                using (MySqlCommand command = new MySqlCommand(sql, connection))
                {
                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            Crew crew = new Crew
                            {
                                Id = reader.GetInt32("id"),
                                Name = reader.GetString("Name"),
                                Capo = reader.GetString("Capo"),
                                TotalCollected = reader.GetFloat("AmtCollected")

                            };
                            crews.Add(crew);
                        }
                    }
                }
            }
        }

        catch (MySqlException error)
        {
            Console.WriteLine($"Error: {error.Message}");
        }
        return View(crews);
    } 
}