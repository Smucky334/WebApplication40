<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApplication40.VIEWS.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Videojuegos - Agregar Producto</title>

     <style>
        @import url('https://fonts.googleapis.com/css2?family=Press+Start+2P&display=swap');

        /* Fuente de videojuegos */
        body {
            font-family: 'Press Start 2P', cursive;
            color: #FFF;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            overflow: hidden;
            background-color: #1e1e2e;
        }

        /* Contenedor de fondo de partículas */
        #particles-js {
            position: absolute;
            width: 100%;
            height: 100%;
            z-index: -1;
            background: linear-gradient(120deg, #1e1e2e, #292943);
        }

        #formContainer {
            position: relative;
            background: rgba(0, 0, 0, 0.85);
            border: 3px solid #ff004d;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.5);
            width: 420px;
            text-align: center;
            z-index: 10;
        }

        h1 {
            font-size: 2em;
            margin: 0 0 15px;
            color: #ffcc00;
            text-shadow: 2px 2px #000;
            animation: pulseText 1.5s infinite;
        }

        @keyframes pulseText {
            0%, 100% { color: #ffcc00; }
            50% { color: #fff; }
        }

        label {
            display: block;
            margin-top: 10px;
            font-size: 0.9em;
            color: #FFF;
        }

        .form-field {
            margin-bottom: 15px;
        }

        .form-field input[type="text"],
        .form-field input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 2px solid #444;
            border-radius: 5px;
            background: #333;
            color: #FFF;
            font-size: 16px;
            outline: none;
            transition: border 0.3s ease;
        }

        .form-field input[type="text"]:focus,
        .form-field input[type="number"]:focus {
            border-color: #ff004d;
        }

        .form-field input[type="file"] {
            margin-top: 5px;
            color: #FFF;
        }

        .btn-submit {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #ff004d, #ffcc00);
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            text-transform: uppercase;
            font-weight: bold;
            margin-top: 10px;
            transition: 0.3s;
        }

        .btn-submit:hover {
            background: linear-gradient(45deg, #ffcc00, #ff004d);
            transform: scale(1.05);
        }
       /* Asegura que el GridView ocupe todo el ancho disponible */
        #gvProductos {
            width: 100%;
            margin-top: 20px;
            background: rgba(0, 0, 0, 0.8);
            color: white;
            border-collapse: collapse;
            border-radius: 5px;
            table-layout: auto;  /* Hace que el ancho de las columnas se ajuste al contenido */
            overflow-x: auto; /* Permite el desplazamiento horizontal si es necesario */
        }

        /* Ajusta el tamaño de las imágenes para que no se corten */
        .grid-image {
            width: 80px; /* Establece un ancho fijo */
            height: 80px; /* Establece una altura fija */
            object-fit: cover; /* Asegura que la imagen se recorte y ajuste al tamaño */
            border-radius: 5px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
        }

        /* Estilo para la cabecera */
        #gvProductos th {
            background-color: #ff004d;
            color: white;
        }

        /* Estilo para las filas alternadas */
        #gvProductos tr:nth-child(even) {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Estilo para las filas al pasar el mouse */
        #gvProductos tr:hover {
            background: rgba(255, 0, 77, 0.3);
        }

    </style>

</head>
<body>
    
      <!-- Fondo animado de partículas -->
    <div id="particles-js"></div>

    <form id="formAgregarProducto" runat="server" enctype="multipart/form-data">
        <div id="formContainer">
            <h1>Agregar Producto 🎮</h1>
            <div class="form-field">
                <label for="txtNombre">Nombre:</label>
                <asp:TextBox ID="txtNombre" runat="server" required="true" />
            </div>
            
            <div class="form-field">
                <label for="txtCantidad">Cantidad:</label>
                <asp:TextBox ID="txtCantidad" runat="server" TextMode="Number" required="true" />
            </div>

            <div class="form-field">
                <label for="txtCosto">Costo:</label>
                <asp:TextBox ID="txtCosto" runat="server" TextMode="Number" required="true" />
            </div>

            <div class="form-field">
                <label for="fileImagen">Imagen:</label>
                <asp:FileUpload ID="fileImagen" runat="server" />
            </div>
            
            <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar Producto" CssClass="btn-submit" OnClick="btnAgregarProducto_Click" />
            
        </div>

        <h2 class="grid-title">Catálogo de Productos</h2>
<asp:GridView ID="gvProductos" runat="server" AutoGenerateColumns="False" CssClass="table-responsive">
    <Columns>
        <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
        <asp:BoundField DataField="Costo" HeaderText="Costo" DataFormatString="{0:C}" />
        <asp:TemplateField HeaderText="Imagen">
            <ItemTemplate>
                <asp:Image ID="imgProducto" runat="server" ImageUrl='<%# Eval("ImagenUrl") %>' CssClass="grid-image" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>

        <div style="overflow-x: auto;">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table-responsive">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />
            <asp:BoundField DataField="Costo" HeaderText="Costo" DataFormatString="{0:C}" />
            <asp:TemplateField HeaderText="Imagen">
                <ItemTemplate>
                    <asp:Image ID="imgProducto" runat="server" ImageUrl='<%# Eval("ImagenUrl") %>' CssClass="grid-image" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</div>


    </form>

   <!-- Agrega el script para generar el efecto de partículas -->
    <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
    <script>
        particlesJS("particles-js", {
            "particles": {
                "number": {
                    "value": 80,
                    "density": { "enable": true, "value_area": 800 }
                },
                "color": { "value": "#ffcc00" },
                "shape": {
                    "type": "circle",
                    "stroke": { "width": 0, "color": "#000" }
                },
                "opacity": {
                    "value": 0.5,
                    "random": false,
                    "anim": { "enable": false }
                },
                "size": {
                    "value": 3,
                    "random": true,
                    "anim": { "enable": false }
                },
                "line_linked": {
                    "enable": true,
                    "distance": 150,
                    "color": "#ff004d",
                    "opacity": 0.4,
                    "width": 1
                },
                "move": {
                    "enable": true,
                    "speed": 4,
                    "direction": "none",
                    "random": false,
                    "straight": false,
                    "out_mode": "out",
                    "bounce": false
                }
            },
            "interactivity": {
                "detect_on": "canvas",
                "events": {
                    "onhover": { "enable": true, "mode": "repulse" },
                    "onclick": { "enable": true, "mode": "push" }
                },
                "modes": {
                    "repulse": { "distance": 100 },
                    "push": { "particles_nb": 4 }
                }
            },
            "retina_detect": true
        });
    </script>
</body>
</html>
