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
using WebApplication40.CONTROLLER;
using WebApplication40.VIEWS;

namespace WebApplication40.VIEWS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            string username = Username.Text.Trim();
            string password = Password.Text.Trim();

            if (ValidarCredenciales(username, password))
            {
                Response.Redirect("~/VIEWS/Index.aspx");
            }
            else
            {
                Response.Write("<script>alert('Usuario o contraseña incorrecta');</script>");
            }
        }

        private bool ValidarCredenciales(string username, string password)
        {
            // Obtiene la cadena de conexión desde Web.config
            string connString = ConfigurationManager.ConnectionStrings["videojuegosConnectionString"].ConnectionString;

            using (MySqlConnection conn = new MySqlConnection(connString))
            {
                conn.Open();

                // Usa 'nombre' en lugar de 'username'
                string query = "SELECT COUNT(1) FROM Usuarios WHERE nombre = @username AND contrasena = @password";

                MySqlCommand cmd = new MySqlCommand(query, conn);

                // Añade los parámetros
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password); // sin encriptar para probar

                // Devuelve verdadero si se encuentra el usuario
                return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
            }
        }




        private string EncryptPassword(string password)
        {
            using (var sha256 = System.Security.Cryptography.SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(System.Text.Encoding.UTF8.GetBytes(password));
                return BitConverter.ToString(bytes).Replace("-", "").ToLower();
            }
        }
    }
}