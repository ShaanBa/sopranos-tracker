using System;
using MySql.Data.MySqlClient;

// connection string this is setting up how its going to connect to the MySql db 
string connstr = "server=localhost;database=sopranos;user=root;password=;";

// using in this context is like with in python i assume like we used with in my 
// db client because with a context manager it allowed us to not worry about leaking info
// closing the conn automatically
using (var connection = new MySqlConnection(connstr))
{
    try // anything can happen working on a connection so do it in a try catch with
    {
        connection.Open();  // maybe this is like in psycopg2 the cursor that the connection uses to do work
        // sample sql query 
        string sql = "SELECT * FROM KnownAssociate";

        // here i am thinking we create a new command called command that will be the sql query  executed by the connection 
        using (MySqlCommand cmd = new MySqlCommand(sql, connection))
        {   
            // we then create this reader object that will read the result of the command 
            using (MySqlDataReader reader = cmd.ExecuteReader())
            {
                // i guess here our reader object will begin reading 
                while (reader.Read())
                {
                    // for each returned tuple we do some work so here i am printing it 
                    KnownAssociate associate = new KnownAssociate
                    {
                        Id = reader.GetInt32("Id"),
                        FirstName = reader.GetString("FirstName"),
                        LastName = reader.GetString("LastName"),
                        RelationType = reader.GetString("RelationType"),
                        MobsterId = reader.GetInt32("MobsterId")
                    };

                    Console.WriteLine($"Id: {associate.Id}, Name: {associate.FirstName} {associate.LastName}, Relation: {associate.RelationType}, MobsterId: {associate.MobsterId}");
                    
                }
            }
        }

        Console.WriteLine("Connected!"); // write some random shtiff 
    }

    catch (MySqlException ex) // if there is a mysql exception output it
    {
        Console.WriteLine($"Error: {ex.Message}");
    }
}

