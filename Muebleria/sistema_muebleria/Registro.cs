using System;
using System.Data;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace sistema_super
{
    public partial class Registro : Form
    {
        MySqlCommand comand;
        MySqlConnection vConexion;
        MySqlDataAdapter vAdapter;
        DataTable vTabla;
        public Registro()
        {
            InitializeComponent();
        }
        

        private void Aceptar_Btn_Click(object sender, EventArgs e)
        {
            try
            {
               
                string query = "insert into clientes values('" + numero_cliente.Text + "','" + nombre_cliente.Text + "', '" + telefono_cliente.Text + "','" + direccion_cliente.Text + "', '" + correo_cliente.Text + "')";
                comand = new MySqlCommand(query,vConexion);
                comand.ExecuteNonQuery();
                Clientes vclientes = new Clientes();

                Registro vadd = new Registro();

                this.Close();


                string v = "Select * from clientes";
                comand = new MySqlCommand(v, vConexion);
                comand.ExecuteNonQuery();

                vAdapter = new MySqlDataAdapter();

                vAdapter.SelectCommand = comand;
                vTabla = new DataTable();
                vAdapter.Fill(vTabla);
                Clientes ob = new Clientes();
                ob.datagridclientes.DataSource = vTabla;
                ob.Show();
            }
            catch (InvalidOperationException Vex)
            {
                MessageBox.Show("Error " + Vex.ToString());
            }
            
        }

        private void actualizarregistro_Click(object sender, EventArgs e)
        {
            
            Aceptar_Btn.Enabled = false;
            try
            {
                string nombre=nombre_cliente.Text;
                string id = numero_cliente.Text;
                string telefono = telefono_cliente.Text;
                string direccion = direccion_cliente.Text;
                string correo = correo_cliente.Text;

                string query = "update clientes set nombre_cli= '" + nombre + "',telefono= '"+ telefono + "', direccion='" + direccion +
                    "',correo='"+ correo + "'where idclientes = '" + id + "';";

                comand = new MySqlCommand(query, vConexion);
                comand.ExecuteNonQuery();

                this.Close();
                string v = "Select * from clientes";
                comand = new MySqlCommand(v, vConexion);
                comand.ExecuteNonQuery();

                vAdapter = new MySqlDataAdapter();

                vAdapter.SelectCommand = comand;
                vTabla = new DataTable();
                vAdapter.Fill(vTabla);
                Clientes ob = new Clientes();
                ob.datagridclientes.DataSource = vTabla;
                ob.Show();
            }
            catch (MySqlException vEx)
            {
                MessageBox.Show("Error" + vEx.ToString());
            }
            
        }

        private void Registro_Load(object sender, EventArgs e)
        {
            vConexion = new MySqlConnection("datasource=127.0.0.1; port = 3306; username=root; password=mysql; database=db_muebleria");
            vConexion.Open();
        } 

    }
}
