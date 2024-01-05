using System;
using System.Windows.Forms;
using System.Data;
using MySql.Data.MySqlClient;
using System.Drawing;

namespace sistema_super
{
    public partial class Form1 : Form
    {
        //Variables globales;
        MySqlCommand comand;
        MySqlConnection vConexion;
        MySqlDataAdapter vAdapter;
        DataTable vTabla;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            String servidor= "datasource=127.0.0.1; port = 3306; username=root; password=mysql; database=db_muebleria";
            try
            {
                vConexion = new MySqlConnection(servidor);
                vConexion.Open();
            }
            catch (MySqlException Vex) { 
                MessageBox.Show("Error " + Vex.ToString());
            }
        }

        private void tabla_clientes_Click(object sender, EventArgs e)
        {
            string query = "Select * from clientes";
            comand = new MySqlCommand(query, vConexion);
            comand.ExecuteNonQuery();

            vAdapter = new MySqlDataAdapter();

            vAdapter.SelectCommand = comand;
            vTabla = new DataTable();
            vAdapter.Fill(vTabla);
            Clientes ob = new Clientes();
            ob.datagridclientes.DataSource = vTabla;
            ob.Show();
        }

        private void tabla_productos_Click(object sender, EventArgs e)
        {
            string query = "Select * from productos";
            comand = new MySqlCommand(query,vConexion);

            comand.ExecuteNonQuery();
            vAdapter = new MySqlDataAdapter();
            vAdapter.SelectCommand = comand;
            vTabla = new DataTable();
            vAdapter.Fill(vTabla);
            //Creando un objeto de el formulario productos.
            productos vProd = new productos();
            vProd.dataProductos.DataSource = vTabla;
            vProd.Show();
            
        }

        private void tabla_cate_Click(object sender, EventArgs e)
        {
            string query = "select * from categorias";
            comand = new MySqlCommand(query, vConexion);
            vAdapter = new MySqlDataAdapter();
            vAdapter.SelectCommand = comand;
            vTabla = new DataTable();
            vAdapter.Fill(vTabla);
            categorias vCategorias = new categorias();
            vCategorias.datagridviewcategorias.DataSource = vTabla;
            vCategorias.Show();
        }

        private void tabla_prove_Click(object sender, EventArgs e)
        {
            string query = "select * from proveedor";
            comand = new MySqlCommand(query, vConexion);
            vAdapter = new MySqlDataAdapter();
            vAdapter.SelectCommand = comand;
            vTabla = new DataTable();
            vAdapter.Fill(vTabla);
            proveedores vProveedores = new proveedores();
            vProveedores.dataGridViewProveedores.DataSource = vTabla;
            vProveedores.Show();
        }

        private void tabla_ventas_Click(object sender, EventArgs e)
        {
            string query = "select * from ventas";
            comand = new MySqlCommand(query, vConexion);
            vAdapter = new MySqlDataAdapter();
            vAdapter.SelectCommand = comand;
            vTabla = new DataTable();
            vAdapter.Fill(vTabla);
            ventas vVentas = new  ventas();
            vVentas.dataGridViewVentas.DataSource = vTabla;
            vVentas.Show();
        }

        private void tabla_ventas_detalles_Click(object sender, EventArgs e)
        {
            string query = "select * from ventas_detalle";
            comand = new MySqlCommand(query, vConexion);
            vAdapter = new MySqlDataAdapter();
            vAdapter.SelectCommand = comand;
            vTabla = new DataTable();
            vAdapter.Fill(vTabla);
            Detalles_de_ventas vDetalles = new Detalles_de_ventas();
            vDetalles.dataGridViewVentas_detalle.DataSource = vTabla;
            vDetalles.Show();
        }

        private void salido_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("¿Cerrar sesión?", "Esta apunto de cerrar sesión", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) == System.Windows.Forms.DialogResult.Yes)
            {
                vConexion.Close();
                this.Close();
                login log = new login();
                log.Show();
                log.mensaje.Text = "Se ha cerrado la sesión";
            }
        }

        
    }
}
