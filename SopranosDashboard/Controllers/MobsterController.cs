namespace SopranosDashboard.Controllers;
using SopranosDashboard.Models;
using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using Microsoft.VisualBasic;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using Org.BouncyCastle.Asn1.Cmp;
using SopranosDashboard.Controllers;

public class MobsterController : Controller
{
    private readonly string _connectionstring;

    public MobsterController(IConfiguration configuration)
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

    public IActionResult Search(string searchTerm)
    {
        List<Mobster> mobsters = new List<Mobster>();

        try
        {
            using (var connection = connectionHelper())
            {
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
                                Id = reader.GetInt16("id"),
                                FirstName = reader.GetString("FirstName"),
                                LastName = reader.GetString("LastName"),
                                Rank = reader.GetString("Rank"),
                                Status = reader.GetString("Status"),
                                CrewID = reader.GetInt16("CrewID"),
                                Moniker = reader.IsDBNull(reader.GetOrdinal("Moniker")) ? null : reader.GetString("Moniker")
                            };
                            mobsters.Add(mobster);
                        }
                    }
                }
            }
        }
        catch (MySqlException error)
        {
            Console.WriteLine($"Error: {error}");
        }

        return View(mobsters);
    }

    public IActionResult Details(int id)
    {
        List<KnownAssociate> associates = new List<KnownAssociate>();

        try
        {
            using (var connection = connectionHelper())
            {
                string sql = "SELECT KnownAssociate.FirstName, KnownAssociate.LastName, RelationType FROM KnownAssociate INNER JOIN Mobster ON KnownAssociate.MobsterID = Mobster.Id WHERE Mobster.Id = @MobsterID";

                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@MobsterId", id);

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            KnownAssociate associate = new KnownAssociate
                            {
                                FirstName = reader.GetString("FirstName"),
                                LastName = reader.GetString("LastName"),
                                RelationType = reader.GetString("RelationType")
                            };
                            associates.Add(associate);
                        }
                    }
                }
            }
        }
        catch (MySqlException error)
        {
            Console.WriteLine($"Error: {error}");
        }

        return View(associates);
    }
}
