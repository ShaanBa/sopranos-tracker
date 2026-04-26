using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using SopranosDashboard.Models;
using MySql.Data.MySqlClient;
using System.Data.SqlTypes;
using Mysqlx.Crud;
namespace SopranosDashboard.Controllers;

public class BusinessFrontController : Controller
{
    private readonly string _connectionstring;

    public BusinessFrontController(IConfiguration configuration)
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
    
    public IActionResult Filter(string industry)
    {
        List<BusinessFront> fronts = new List<BusinessFront>();

        try
        {
            using (var connection = connectionHelper())
            {
                string sql = "SELECT * FROM BusinessFront Where Industry = @industry;";

                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@industry", industry);

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            BusinessFront front = new BusinessFront
                            {
                                Id = reader.GetInt32("Id"),
                                Name = reader.GetString("Name"),
                                Industry = reader.GetString("Industry"),
                                StreetAddress = reader.GetString("StreetAddress")
                            };

                            fronts.Add(front);
                        }
                    }
                }
            }
        } 
        catch (MySqlException error)
        {
            Console.WriteLine($"Error: {error}");
        }

        return View(fronts);
    }

    public IActionResult TopEarners(int limit)
    {
        List<BusinessFront> fronts = new List<BusinessFront>();

        try
        {
            using (var connection = connectionHelper())
            {
                string sql = "SELECT BusinessFront.Id, BusinessFront.Industry, BusinessFront.StreetAddress, BusinessFront.Name, sum(Amount) as AmtCollected FROM BusinessFront INNER JOIN CollectionLog on BusinessFront.id = CollectionLog.BusinessID GROUP BY BusinessFront.Name, BusinessFront.Id, BusinessFront.Industry, BusinessFront.StreetAddress ORDER BY AmtCollected DESC LIMIT @limit;";

                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@limit", limit);

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            BusinessFront front = new BusinessFront
                            {
                                Id = reader.GetInt32("Id"),
                                Name = reader.GetString("Name"),
                                Industry = reader.GetString("Industry"),
                                StreetAddress = reader.GetString("StreetAddress"),
                                TotalCollected = reader.GetFloat("AmtCollected")
                            };

                            fronts.Add(front);
                        }
                    }
                }
            }
        } 
        catch (MySqlException error)
        {
            Console.WriteLine($"Error: {error}");
        }

        return View(fronts);
    }
}