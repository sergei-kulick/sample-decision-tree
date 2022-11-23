using System.Data;
using System.Data.SqlClient;

namespace sample_decision_tree;

public class DecisionTreeRepo
{
    public async Task<IEnumerable<Model>> GetComponents(int id)
    {
        await using var connection = new SqlConnection("Server=host.docker.internal\\db-container,1533;Initial Catalog=decision_tree;User id=sa;Password=tZnh4A0VO90%;");

        await using var command = connection.CreateCommand();
        command.CommandType = CommandType.Text;
        command.CommandText = @"
            SELECT tree.Id, type.Name, value.InnerValue, value.DisplayValue
            FROM DecisionTree as tree
                INNER JOIN ComponentType as type
                    ON tree.ComponentTypeId = type.Id
                LEFT JOIN ComponentValue as value
                    ON tree.ComponentValueId = value.Id
            WHERE tree.parentId=@id
";
        command.Parameters.AddWithValue("@id", id);

        connection.Open();
        var reader = await command.ExecuteReaderAsync(CancellationToken.None);
        var listComponents = new List<Model>();
        while (reader.Read())
        {
            listComponents.Add(new Model
            {
                Id = reader.GetInt32("Id"),
                ComponentType = reader.GetString("Name"),
                InnerValue = await reader.IsDBNullAsync("InnerValue") ? null : reader.GetString("InnerValue"),
                DisplayValue = await reader.IsDBNullAsync("DisplayValue") ? null : reader.GetString("DisplayValue")
            });
        }

        return listComponents;
    }
}