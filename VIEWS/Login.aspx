<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication40.VIEWS.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Login</title>

    <style>
       body {
            background-image: url('https://www.muycomputer.com/wp-content/uploads/2021/03/Zelda.jpg'); /* Reemplaza con una imagen de Zelda: Breath of the Wild */
            background-size: cover;
            background-attachment: fixed;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            color: white;
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
        }
        .login-container {
            position: relative;
            z-index: 1;
            background-color: rgba(20, 20, 20, 0.8);
            padding: 40px;
            border-radius: 10px;
            text-align: center;
            width: 350px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(5px);
            animation: fadeIn 1s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
        .login-container h2 {
            font-size: 28px;
            font-weight: bold;
            color: #ffdd57; /* Inspirado en los colores del juego */
        }
        .input-field {
            background-color: rgba(255, 255, 255, 0.2);
            border: none;
            padding: 10px;
            border-radius: 5px;
            color: white;
            width: 100%;
            margin: 10px 0;
        }
        .login-button {
            background-color: #009688;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            width: 100%;
            margin-top: 20px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        .login-button:hover {
            background-color: #00796b;
        }
        .login-options, .register-link {
            color: #a0e3ff;
            text-decoration: none;
            transition: color 0.3s;
        }
        .register-link:hover, .login-options a:hover {
            color: #ffdd57;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
            <div class="overlay"></div>
        <div class="login-container">
            <h2>Game Zone Login</h2>
            <asp:TextBox ID="Username" runat="server" CssClass="input-field" placeholder="Username"></asp:TextBox>
            <asp:TextBox ID="Password" runat="server" CssClass="input-field" placeholder="Password" TextMode="Password"></asp:TextBox>
            <div class="login-options">
                <asp:CheckBox ID="RememberMe" runat="server" Text="Remember me" ForeColor="white" />
                <a href="#" style="color: #a0e3ff;">Forgot Password?</a>
            </div>
            <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="login-button" OnClick="LoginButton_Click" />
            <div style="margin-top: 10px;">
                <span>Don't have an account?</span>
                <a href="Registrar.aspx" class="register-link">Register</a>
            </div>
        </div>
    </form>
</body>
</html>
