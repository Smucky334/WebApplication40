using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using WebApplication40.Models.DataExamenTableAdapters;

namespace WebApplication40.VIEWS
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)  // Solo cargar productos la primera vez que se carga la página
            {
                CargarProductos();
            }
        }

        protected void btnAgregarProducto_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text;
            int cantidad = int.Parse(txtCantidad.Text);
            decimal costo = decimal.Parse(txtCosto.Text);
            byte[] imagenData = null;

            if (fileImagen.HasFile)
            {
                using (BinaryReader br = new BinaryReader(fileImagen.PostedFile.InputStream))
                {
                    imagenData = br.ReadBytes((int)fileImagen.PostedFile.InputStream.Length);
                }
            }

            string connectionString = ConfigurationManager.ConnectionStrings["videojuegosConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO Productos (Nombre, Cantidad, Costo, Imagen) VALUES (@Nombre, @Cantidad, @Costo, @Imagen)";
                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Cantidad", cantidad);
                    cmd.Parameters.AddWithValue("@Costo", costo);
                    cmd.Parameters.AddWithValue("@Imagen", imagenData ?? (object)DBNull.Value);

                    cmd.ExecuteNonQuery();
                }
            }

            // Llama a CargarProductos para actualizar la tabla de productos
            CargarProductos();
        }

        private void CargarProductos()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["videojuegosConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string query = "SELECT ID, Nombre, Cantidad, Costo, Imagen FROM Productos";

                using (MySqlCommand cmd = new MySqlCommand(query, conn))
                using (MySqlDataReader reader = cmd.ExecuteReader())
                {
                    DataTable dt = new DataTable();
                    dt.Load(reader);

                    // Verifica si la consulta devolvió resultados
                    if (dt.Rows.Count == 0)
                    {
                        Response.Write("<script>alert('No se encontraron productos.');</script>");
                    }

                    dt.Columns.Add("ImagenUrl", typeof(string));

                    foreach (DataRow row in dt.Rows)
                    {
                        if (row["Imagen"] != DBNull.Value)
                        {
                            byte[] imagenData = (byte[])row["Imagen"];
                            string base64String = Convert.ToBase64String(imagenData);
                            row["ImagenUrl"] = "data:image/jpg;base64," + base64String;
                        }
                        else
                        {
                            row["ImagenUrl"] = ""; // Si no hay imagen, establece URL vacía
                        }
                    }

                    // Asigna el DataSource y actualiza el GridView
                    gvProductos.DataSource = dt;
                    gvProductos.DataBind();
                }
            }
        }
    }
}