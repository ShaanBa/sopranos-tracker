using Microsoft.AspNetCore.Mvc;
using MySql.Data.MySqlClient;
using Mysqlx.Crud;
using SopranosDashboard.Controllers;

public class MobsterController : Controller // tells c# class our mobster controller inherits functionality from base controller
{
    public IActionResult Search(string searchTerm)
    {
        string connectionstring = "server=localhost;database=sopranos;user=root;password=;";

        using (var connection = new MySqlConnection(connectionstring))
        {
            try
            {
                connection.Open();
                string sql = "SELECT * FROM Mobster WHERE Moniker = @search OR `Rank` = @seatch OR Status = @search";

                using (var command = new MySqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@search", searchTerm);

                    using (MySqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            
                        }
                    }
                }
            }
        }
        return View();
    }
}